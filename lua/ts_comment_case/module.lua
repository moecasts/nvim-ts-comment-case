local default_cmd = 'tscc'

---@class CustomModule
local M = {
  cmd = default_cmd,
}

M.setup = function(opts)
  if opts.cmd then
    M.cmd = opts.cmd
  end
end

local function get_cmd_args(config, content)
  local cmd = config.cmd or default_cmd

  local cmd_args = { cmd }

  local cmd_case = config.case or 'jsdoc'

  if cmd_case then
    table.insert(cmd_args, '--case')
    table.insert(cmd_args, cmd_case)
  end

  local cmd_action = config.action or 'transform'

  if cmd_action then
    table.insert(cmd_args, '--action')
    table.insert(cmd_args, cmd_action)
  end

  table.insert(cmd_args, content)

  return cmd_args
end

M.tscc_all = function(config, opts)
  local oldContentArray = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local oldContent = table.concat(oldContentArray, '\n')

  local cmd_args = get_cmd_args(config, oldContent)

  local output = vim.fn.system(cmd_args)

  if vim.v.shell_error ~= 0 then
    print('error: ' .. output)
    return
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n'))
end

M.tscc_range = function(config, opts)
  -- method-1. get range from user commamd
  local lstart = opts and opts.line1 - 1
  local lend = opts and opts.line2

  -- method-2. get range from vim function
  local m = vim.fn.mode()                    -- detect current mode
  if m == 'v' or m == 'V' or m == '\22' then -- <C-V>
    vim.cmd([[execute "normal! \<ESC>"]])
    lstart = vim.fn.getpos("'<")[2] - 1
    lend = vim.fn.getpos("'>")[2]
  end

  local oldContentArray = vim.api.nvim_buf_get_lines(0, lstart, lend, false)

  local oldContent = table.concat(oldContentArray, '\n')

  local cmd_args = get_cmd_args(config, oldContent)

  local output = vim.fn.system(cmd_args)

  if vim.v.shell_error ~= 0 then
    print('error: ' .. output)
    return
  end

  vim.api.nvim_buf_set_lines(0, lstart, lend, false, vim.split(output, '\n'))
end

-- transform start
M.transform_jsdoc = function(opts)
  return M.tscc_all({ cmd = M.cmd, action = 'transform', case = 'jsdoc' }, opts)
end

M.range_transform_jsdoc = function(opts)
  return M.tscc_range({ cmd = M.cmd, action = 'transform', case = 'jsdoc' }, opts)
end

M.transform_single = function(opts)
  return M.tscc_all({ cmd = M.cmd, action = 'transform', case = 'single' }, opts)
end

M.range_transform_single = function(opts)
  return M.tscc_range({ cmd = M.cmd, action = 'transform', case = 'single' }, opts)
end
-- transform end

-- move start
M.move_trailing_comment_to_leading = function(opts)
  return M.tscc_all({ cmd = M.cmd, action = 'move' }, opts)
end

M.range_move_trailing_comment_to_leading = function(opts)
  return M.tscc_range({ cmd = M.cmd, action = 'move' }, opts)
end
-- move end

-- transform start
M.move_and_transform_jsdoc = function(opts)
  return M.tscc_all({ cmd = M.cmd, action = 'move_and_transform', case = 'jsdoc' }, opts)
end

M.range_move_and_transform_jsdoc = function(opts)
  return M.tscc_range({ cmd = M.cmd, action = 'move_and_transform', case = 'jsdoc' }, opts)
end

M.move_and_transform_single = function(opts)
  return M.tscc_all({ cmd = M.cmd, action = 'move_and_transform', case = 'single' }, opts)
end

M.range_move_and_transform_single = function(opts)
  return M.tscc_range({ cmd = M.cmd, action = 'move_and_transform', case = 'single' }, opts)
end
-- transform end

return M
