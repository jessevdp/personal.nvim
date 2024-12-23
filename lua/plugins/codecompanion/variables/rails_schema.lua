local log = require("codecompanion.utils.log")
local path = require("plenary.path")

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

---@class CodeCompanion.Variable.RailsSchema: CodeCompanion.Variable
local RailsSchemaVariable = {}

---@param _ CodeCompanion.VariableArgs
function RailsSchemaVariable.new(_)
  local self = setmetatable({}, { __index = RailsSchemaVariable })
  return self
end

---@return string
function RailsSchemaVariable:execute()
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

  local output = table.concat(lines, "\n")
  log:trace("Rails Schema Variable:\n---\n%s", output)
  return output
end

return RailsSchemaVariable
