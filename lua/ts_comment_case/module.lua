---@class CustomModule
local M = {}

local default_cmd = "tscc"

M.dump = function(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

M.remove_last_break_line = function(content)
  return content:gsub("\r?\n$", "")
end

M.tscc_replace_all = function(config, opts)
  local oldContentArray = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local oldContent = table.concat(oldContentArray, "\n")

  local cmd = config.cmd or default_cmd

  local cmd_args = {
    cmd,
    oldContent,
  }

  local output = vim.fn.system(cmd_args)

  if vim.v.shell_error ~= 0 then
    print("error: " .. output)
    return
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))
end

M.tscc_replace_range = function(config, opts)
  -- method-1. get range from user commamd
  local lstart = opts and opts.line1 - 1
  local lend = opts and opts.line2

  -- method-2. get range from vim function
  local m = vim.fn.mode() -- detect current mode
  if m == "v" or m == "V" or m == "\22" then -- <C-V>
    vim.cmd([[execute "normal! \<ESC>"]])
    lstart = vim.fn.getpos("'<")[2] - 1
    lend = vim.fn.getpos("'>")[2]
  end

  local oldContentArray = vim.api.nvim_buf_get_lines(0, lstart, lend, false)

  local oldContent = table.concat(oldContentArray, "\n")

  local cmd = config.cmd or default_cmd

  local cmd_args = {
    cmd,
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
