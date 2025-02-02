local M = {}

local config = {
  name = "aio_openai",
  formatted_name = "AiO OpenAI",
  env = {
    api_key = "cmd:cat ~/.aio.key", -- TODO: move to secret store
    endpoint = "https://aio.azure-api.net",
  },
  schema = {
    model = {
      default = "gpt-4o",
      choices = {
        "gpt-4o",
        "gpt-4o-mini",
        ["o1-preview"] = { opts = { stream = false } },
      },
    },
  },
}

M.make = function()
  return require("codecompanion.adapters").extend("azure_openai", config)
end

return M
