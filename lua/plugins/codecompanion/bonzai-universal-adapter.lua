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
        default = "claude-3-7-sonnet",
        choices = {
          "gpt-4o",
          "gpt-4o-mini",
          ["o3-mini"] = { opts = { can_reason = true } },
          ["o1"] = { opts = { stream = false } },
          ["o1-preview"] = { opts = { stream = true } },
          "claude-3-haiku",
          "claude-3-5-sonnet",
          ["claude-3-7-sonnet"] = { opts = { can_reason = true } },
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
