local path = require("plenary.path")

local design_prompt = [[
You are a domain driven design and Ruby on Rails expert.
The user will provide you with details about their Rails application.
The user will ask you to help model a single specific concept.

Analyze the provided concept carefully and think step by step. Consider the following aspects:
1. The core purpose of the concept
2. Its relationships with other potential entities in the system
3. The attributes that would best represent this concept in a database

Based on your analysis, suggest an appropriate model name and attributes to effectively model the concept.
Follow these guidelines:

1. Choose a clear, singular noun for the model name that accurately represents the concept
2. Select attributes that capture the essential characteristics of the concept
3. Use appropriate data types for each attribute (e.g. string, integer, datetime, boolean)
4. Consider adding foreign keys for relationships with other models, if applicable

After determining the model structure, generate the Rails commands to create the model and any associated resources.
Include all relevant \`generate\` commands in a single Markdown shell code block at the end of your response.

The \`generate\` commands should ONLY include the type of generator and arguments, not the \`rails generate\` part
(e.g.: \`model User name:string\` but not \`rails generate model User name:string\`).
NEVER include commands to migrate the database as part of the code block.
NEVER include redundant commands (e.g. including the migration and model generation commands for the same model).
]]

local function get_rails_schema()
  local workspace_dir = vim.uv.cwd()

  local schema_file = path:new(workspace_dir .. "/db/schema.rb")
  if schema_file:is_file() then
    return schema_file:read(), vim.filetype.match(schema_file)
  end

  local structure_file = path:new(workspace_dir .. "/db/structure.sql")
  if structure_file:is_file() then
    return structure_file:read(), vim.filetype.match(structure_file)
  end
end

local M = {}
M.strategy = "workflow"
M.description = "Generate a Rails model"

M.opts = {}
M.opts.short_name = "rails_design"

M.condition = function()
  local schema_content = get_rails_schema()
  if schema_content then
    return true
  else
    return false
  end
end

local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

M.prompts = {
  {
    {
      role = constants.SYSTEM_ROLE,
      content = design_prompt,
      opts = {
        visible = false,
      },
    },
    {
      role = constants.SYSTEM_ROLE,
      content = function()
        local log = require("codecompanion.utils.log")
        local schema_content, schema_ft = get_rails_schema()

        if not schema_content then
          log:warn("Could not read the Rails schema")
          return ""
        end

        local lines = {
          "Here is the existing application schema:",
          "",
          "```" .. schema_ft,
          schema_content,
          "```",
        }

        return table.concat(lines, "\n")
      end,
      opts = {
        visible = false,
      },
    },
    {
      role = constants.USER_ROLE,
      content = "I need to model ",
      opts = {
        auto_submit = false,
      },
    },
  },
}

return M
