local M = {}

M.config = {
  name = "aio_openai",
  env = {
    url = "https://iogpt-api-management-service.azure-api.net/openai/api/proxy/openai",
    api_key = os.getenv("IOGPT_API_KEY"),
    chat_url = "/chat/completions",
  },
  schema = {
    model = {
      default = "gpt-4o",
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

M.setup = function()
  return require("codecompanion.adapters").extend("openai_compatible", M.config)
end

return M
