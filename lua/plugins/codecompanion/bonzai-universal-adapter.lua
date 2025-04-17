local M = {}

local config = {
  name = "bonzai",
  formatted_name = "Bonzai",
  env = {
    url = "https://api.bonzai.iodigital.com",
    chat_url = "/universal/chat/completions",
    api_key = "cmd:op read op://Employee/bonzai-api/credential --no-newline",
    -- api_key = "cmd:cat ~/.bonzai.key", -- TODO: move to secret store
  },
  headers = {
    ["Content-Type"] = "application/json",
    ["api-key"] = "${api_key}",
  },
  schema = {
    model = {
      default = "claude-3-7-sonnet",
      choices = {
        "claude-3-haiku",
        "claude-3-5-sonnet",
        "claude-3-7-sonnet",
        "gpt-4o",
        "gpt-4o-mini",
        "o1-preview",
        "o1",
        "o3-mini",
      },
    },
  },
}

M.make = function()
  return require("codecompanion.adapters").extend("openai_compatible", config)
end

return M
