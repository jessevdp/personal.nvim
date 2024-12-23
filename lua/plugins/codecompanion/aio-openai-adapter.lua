local M = {}

local config = {
  name = "aio_openai",
  env = {
    url = "https://iogpt-api-management-service.azure-api.net/openai/api/proxy/openai",
    api_key = os.getenv("IOGPT_API_KEY"),
    chat_url = "/chat/completions",
  },
  schema = {
    model = {
      default = "gpt-4o",
      choices = {
        "gpt-4o",
        "gpt-4o-mini",
        "gpt-4",
        "gpt-4-32k",
        "gpt-3.5-turbo",
        "gpt-3.5-turbo-16k",
      },
    },
  },
  handlers = {
    -- AiO OpenAI proxy does not accept `{ "options": {} }` in the POST body
    form_parameters = function(self, params, messages)
      local openai = require("codecompanion.adapters.openai")
      local parameters = openai.handlers.form_parameters(self, params, messages)
      parameters["options"] = nil
      return parameters
    end,
  },
}

M.make = function()
  return require("codecompanion.adapters").extend("openai_compatible", config)
end

return M
