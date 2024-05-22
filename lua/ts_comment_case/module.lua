---@class CustomModule
local M = {}

M.remove_last_break_line = function(content)
  return content:gsub("\r?\n$", "")
end

M.tscc_replace_all = function()
  local oldContentArray = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local oldContent = table.concat(oldContentArray, "\n")

  local cmd_args = {
    "tscc",
    oldContent,
  }

  local output = vim.fn.system(cmd_args)

  if vim.v.shell_error ~= 0 then
    print("error: " .. output)
    return
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))
end

M.tscc_replace_range = function(opts)
  local lstart = opts.line1 - 1
  local lend = opts.line2

  local oldContentArray = vim.api.nvim_buf_get_lines(0, lstart, lend, false)

  local oldContent = table.concat(oldContentArray, "\n")

  local cmd_args = {
    "tscc",
    oldContent,
  }

  local output = vim.fn.system(cmd_args)

  if vim.v.shell_error ~= 0 then
    print("error: " .. output)
    return
  end

  vim.api.nvim_buf_set_lines(0, lstart, lend, false, vim.split(output, "\n"))
end

return M
