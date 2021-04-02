-- ===================================
-- BUILTIN-LSP DIAGNOSTIC COUNT BUBBLE
-- ===================================
-- Created by PatOConnor43 <github.com/PatOConnor43>

local settings = {
  symbol = vim.g.bubbly_symbols,
  color = vim.g.bubbly_colors,
  style = vim.g.bubbly_styles,
  filter = vim.g.bubbly_filter,
}

---@type fun(settings: table, module_name: string): table
local process_settings = require'bubbly.utils.module'.process_settings

settings = process_settings(settings, 'builtinlsp.diagnostic_count')

---@type fun(filter: table): boolean
local process_filter = require'bubbly.utils.module'.process_filter

-- Returns bubble that shows built-in lsp diagnostics
---@param inactive boolean
---@return Segment[]
return function(inactive)
  if inactive then return nil end
  if not process_filter(settings.filter) then return nil end
  local counts = {}
  for _, err in ipairs({'Error', 'Warning', 'Information', 'Hint'}) do
      counts[err] = vim.lsp.diagnostic.get_count(0, err)
  end
  local error_count = vim.lsp.diagnostic.get_count(0, 'Error')
  local warning_count = vim.lsp.diagnostic.get_count(0, 'Warning')
  return {
    {
      data = counts['Error'] ~= 0 and settings.symbol.error:format(error_count),
      color = settings.color.error,
      style = settings.style.error
    },
    {
      data = counts['Warning'] ~= 0 and settings.symbol.warning:format(warning_count),
      color = settings.color.warning,
      style = settings.style.warning
    },
    {
      data = counts['Information'] ~= 0 and 'I' .. counts['Information'],
    },
    {
      data = counts['Hint'] ~= 0 and 'H' .. counts['Hint'],
    },
  }
end
