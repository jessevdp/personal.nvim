local M = {}

M.make = function()
  local openai_adapter = require("codecompanion.adapters.http.openai")
  local config = {
    name = "bonzai",
    formatted_name = "Bonzai",
    url = "https://api-v2.bonzai.iodigital.com/v1/chat/completions",
    env = {
      -- api_key = "cmd:op read op://Employee/bonzai-api/credential --no-newline",
      api_key = "cmd:cat ~/.bonzai-v2.key", -- TODO: move to secret store
    },
    schema = {
      model = {
        order = 1,
        mapping = "parameters",
        type = "enum",
        desc = "ID of the model to use.",
        default = "gpt-5",
        choices = {
          ["o4-mini"] = {
            opts = { has_vision = true, can_reason = true },
          },
          ["o3-mini"] = {
            opts = { can_reason = true },
          },
          ["o3"] = {
            opts = { has_vision = true, can_reason = true },
          },
          ["gpt-4.1"] = {
            opts = { has_vision = true },
          },
          ["gpt-5"] = {
            opts = { can_reason = true, has_vision = true },
          },
          ["gpt-5-mini"] = {
            opts = { can_reason = true, has_vision = true },
          },
          ["gpt-5-nano"] = {
            opts = { can_reason = true, has_vision = true },
          },
          ["claude-4-sonnet"] = {
            opts = { can_reason = true, has_vision = true },
          },
        },
      },
      reasoning_effort = vim.deepcopy(openai_adapter.schema.reasoning_effort),
      temperature = vim.deepcopy(openai_adapter.schema.temperature),
      top_p = vim.deepcopy(openai_adapter.schema.top_p),
      stop = vim.deepcopy(openai_adapter.schema.stop),
      max_tokens = vim.deepcopy(openai_adapter.schema.max_tokens),
      presence_penalty = vim.deepcopy(openai_adapter.schema.presence_penalty),
      frequency_penalty = vim.deepcopy(openai_adapter.schema.frequency_penalty),
      logit_bias = vim.deepcopy(openai_adapter.schema.logit_bias),
    },
  }
  return require("codecompanion.adapters").extend("openai_compatible", config)
end

return M
