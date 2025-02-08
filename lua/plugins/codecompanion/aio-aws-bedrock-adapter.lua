local log = require("codecompanion.utils.log")
-- local tokens = require("codecompanion.utils.tokens")
local utils = require("codecompanion.utils.adapters")

local input_tokens = 0
local output_tokens = 0

local function clean_and_parse_streamed_data(data)
  local segments = {}
  -- local pattern = ":message%-type%z*event%z*(%b{})"
  local pattern = "event(%b{})"

  for json_string in string.gmatch(data, pattern) do
    local ok, json = pcall(vim.json.decode, json_string, { luanil = { object = true } })
    if ok and json then
      table.insert(segments, json)
    else
      return false, nil
    end
  end

  return true, segments
end

---@class AioAmazonBedrock.Adapter: CodeCompanion.Adapter
local config = {
  name = "aio_aws_bedrock",
  formatted_name = "AiO AWS Bedrock",
  roles = {
    llm = "assistant",
    user = "user",
  },
  features = {
    tokens = true,
    text = true,
    vision = true,
  },
  url = "${endpoint}/bedrock/model/${model}/converse-stream",
  env = {
    api_key = "cmd:cat ~/.aio.key", -- TODO: move to secret store
    endpoint = "https://aio.azure-api.net",
    model = "schema.model.default",
  },
  headers = {
    ["content-type"] = "application/json",
    ["api-key"] = "${api_key}",
  },
  parameters = {},
  opts = {
    stream = true,
    -- cache_breakpoints = 4, -- Cache up to this many messages
    -- cache_over = 300, -- Cache any message which has this many tokens or more
  },
  handlers = {
    ---Set the parameters
    ---@param self CodeCompanion.Adapter
    ---@param params table
    ---@param messages table
    ---@return table
    form_parameters = function(self, params, messages)
      return params
    end,

    ---Set the format of the role and content for the messages from the chat buffer
    ---@param self CodeCompanion.Adapter
    ---@param messages table Format is: { { role = "user", content = "Your prompt here" } }
    ---@return table
    form_messages = function(self, messages)
      -- Extract and format system messages
      local system = vim
        .iter(messages)
        :filter(function(msg)
          return msg.role == "system"
        end)
        :map(function(msg)
          return {
            type = "text",
            text = msg.content,
          }
        end)
        :totable()
      system = next(system) and system or nil

      -- Remove system messages and merge user/assistant messages
      messages = utils.merge_messages(vim
        .iter(messages)
        :filter(function(msg)
          return msg.role ~= "system"
        end)
        :totable())

      for i = #messages, 1, -1 do
        local message = messages[i]
        message.content = {
          {
            type = "text",
            text = message.content,
          },
        }
      end

      return { system = system, messages = messages }
    end,

    ---Returns the number of tokens generated from the LLM
    ---@param self CodeCompanion.Adapter
    ---@param data string The data from the LLM
    ---@return number|nil
    tokens = function(self, data)
      if data then
        data = data:sub(6)
        local ok, json = pcall(vim.json.decode, data)

        if ok then
          if json.messageStart then
            input_tokens = json.metadata.usage.inputTokens or 0
            output_tokens = json.metadata.usage.outputTokens or 0
          end
          if json.messageDelta then
            return (input_tokens + output_tokens + json.metadata.usage.outputTokens)
          end
        end
      end
    end,

    ---Output the data from the API ready for insertion into the chat buffer
    ---@param self CodeCompanion.Adapter
    ---@param data string The streamed JSON data from the API, also formatted by the format_data handler
    ---@return table|nil
    chat_output = function(self, data)
      if not data or data == "" then
        return
      end

      local ok, parts = clean_and_parse_streamed_data(data)

      if not ok or not parts then
        return { status = "error", output = {} }
      end

      local timestamp = os.date("%Y%m%d_%H%M%S")
      local filename = string.format("%s/%s.lua", "debug_output", timestamp)
      local file = io.open(filename, "w")
      if file then
        local inspected_data = "return " .. vim.inspect(parts)
        file:write(inspected_data)
        file:close()
        print("Data written to " .. filename)
      else
        print("Error opening file for writing.")
      end

      local output = {}

      for _, part in ipairs(parts) do
        if part.role then
          output.role = part.role
        end

        if part.delta and part.delta.text then
          output.content = (output.content or "") .. part.delta.text
        end
      end

      return {
        status = "success",
        output = output,
      }
    end,

    ---Output the data from the API ready for inlining into the current buffer
    ---@param self CodeCompanion.Adapter
    ---@param data table The streamed JSON data from the API, also formatted by the format_data handler
    ---@param context table Useful context about the buffer to inline to
    ---@return table|nil
    inline_output = function(self, data, context)
      if type(data) == "string" and string.sub(data, 1, 6) == "event:" then
        return
      end

      if data and data ~= "" then
        data = data:sub(6)
        local ok, json = pcall(vim.json.decode, data, { luanil = { object = true } })

        if ok then
          if json.contentBlockDelta then
            return json.delta.text
          end
        end
      end
    end,

    ---Function to run when the request has completed. Useful to catch errors
    ---@param self CodeCompanion.Adapter
    ---@param data table
    ---@return nil
    on_exit = function(self, data)
      if data.status >= 400 then
        log:error("Error %s: %s", data.status, data.body)
      end
    end,
  },
  schema = {
    -- model does not exist in the AWS Bedrock API, but this is used as the deployment in the URL.
    model = {
      order = 1,
      mapping = "parameters",
      type = "enum",
      desc = "The model that will complete your prompt.",
      default = "anthropic.claude-3-5-sonnet-20240620-v1:0",
      choices = {
        "anthropic.claude-3-5-sonnet-20240620-v1:0",
        "anthropic.claude-3-haiku-20240307-v1:0",
      },
    },
    maxTokens = {
      order = 2,
      mapping = "parameters.inferenceConfig",
      type = "number",
      optional = true,
      default = 4096,
      desc = "The maximum number of tokens to generate before stopping. This parameter only specifies the absolute maximum number of tokens to generate. Different models have different maximum values for this parameter.",
      validate = function(n)
        return n > 0 and n <= 8192, "Must be between 0 and 8192"
      end,
    },
    temperature = {
      order = 3,
      mapping = "parameters.inferenceConfig",
      type = "number",
      optional = true,
      default = 0,
      desc = "Amount of randomness injected into the response. Ranges from 0.0 to 1.0. Use temperature closer to 0.0 for analytical / multiple choice, and closer to 1.0 for creative and generative tasks. Note that even with temperature of 0.0, the results will not be fully deterministic.",
      validate = function(n)
        return n >= 0 and n <= 1, "Must be between 0 and 1.0"
      end,
    },
    topP = {
      order = 4,
      mapping = "parameters.inferenceConfig",
      type = "number",
      optional = true,
      default = nil,
      desc = "Computes the cumulative distribution over all the options for each subsequent token in decreasing probability order and cuts it off once it reaches a particular probability specified by top_p",
      validate = function(n)
        return n >= 0 and n <= 1, "Must be between 0 and 1"
      end,
    },
    stopSequences = {
      order = 6,
      mapping = "parameters.inferenceConfig",
      type = "list",
      optional = true,
      default = nil,
      subtype = {
        type = "string",
      },
      desc = "Sequences where the API will stop generating further tokens",
      validate = function(l)
        return #l >= 1, "Must have more than 1 element"
      end,
    },
  },
}

local M = {}
M.make = function()
  return require("codecompanion.adapters").new(config)
end
return M
