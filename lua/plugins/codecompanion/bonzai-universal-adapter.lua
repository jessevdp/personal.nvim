local M = {}

M.make = function()
  local openai_adapter = require("codecompanion.adapters.openai")
  local config = {
    name = "bonzai",
    formatted_name = "Bonzai",
    url = "https://api.bonzai.iodigital.com/universal/chat/completions",
    env = {
      -- api_key = "cmd:op read op://Employee/bonzai-api/credential --no-newline",
      api_key = "cmd:cat ~/.bonzai.key", -- TODO: move to secret store
    },
    headers = {
      ["Content-Type"] = "application/json",
      ["api-key"] = "${api_key}",
    },
    schema = {
      model = {
        order = 1,
        mapping = "parameters",
        type = "enum",
        desc = "ID of the model to use.",
        default = "claude-4-sonnet",
        choices = {
          ["o4-mini"] = { opts = { has_vision = true, can_reason = true } },
          ["o3-mini"] = { opts = { can_reason = true } },
          ["o3"] = { opts = { has_vision = true, can_reason = true } },
          ["o1"] = { opts = { has_vision = true, can_reason = true } },
          ["gpt-4.1"] = { opts = { has_vision = true } },
          ["gpt-4o"] = { opts = { has_vision = true } },
          ["gpt-4o-mini"] = { opts = { has_vision = true } },

          "claude-3-haiku",
          ["claude-3-5-sonnet"] = { opts = { has_vision = true } },
          ["claude-3-7-sonnet"] = {
            opts = { can_reason = true, has_vision = true, has_token_efficient_tools = true },
          },
          ["claude-4-sonnet"] = { opts = { can_reason = true, has_vision = true } },
        },
      },
      reasoning_effort = vim.deepcopy(openai_adapter.schema.reasoning_effort),
      temperature = vim.deepcopy(openai_adapter.schema.temperature),
      top_p = vim.deepcopy(openai_adapter.schema.top_p),
      stop = vim.deepcopy(openai_adapter.schema.stop),
      presence_penalty = vim.deepcopy(openai_adapter.schema.presence_penalty),
      frequency_penalty = vim.deepcopy(openai_adapter.schema.frequency_penalty),
    },
  }
  return require("codecompanion.adapters").extend("openai_compatible", config)
end

return M
