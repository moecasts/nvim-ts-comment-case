local module = require('ts_comment_case.module')

---@class Keymaps
local M = {}

local function map(mode, key, cmd, opts)
  if key ~= false and type(key) == 'string' then
    vim.keymap.set(mode, key, cmd, opts)
  end
end

M.setup = function(keymaps)
  -- set keymaps
  map('n', keymaps.transform_jsdoc, module.transform_jsdoc, {
    desc = 'Comment case as JSDoc all lines',
    noremap = true,
    silent = true,
  })

  map('v', keymaps.range_transform_jsdoc, module.range_transform_jsdoc, {
    desc = 'Comment case as JSDoc selected lines',
    noremap = true,
    silent = true,
  })

  map('n', keymaps.transform_single, module.transform_single, {
    desc = 'Comment case as single line all lines',
    noremap = true,
    silent = true,
  })

  map('v', keymaps.range_transform_single, module.range_transform_single, {
    desc = 'Comment case as single line selected lines',
    noremap = true,
    silent = true,
  })

  map('n', keymaps.move_trailing_comment_to_leading, module.move_trailing_comment_to_leading, {
    desc = 'Move tailing comment to leading comment all lines',
    noremap = true,
    silent = true,
  })

  map('v', keymaps.range_move_trailing_comment_to_leading, module.range_move_trailing_comment_to_leading, {
    desc = 'Move tailing comment to leading comment selected lines',
    noremap = true,
    silent = true,
  })

  map('n', keymaps.move_and_transform_jsdoc, module.move_and_transform_jsdoc, {
    desc = 'Move Trailing comment and Comment case as JSDoc all lines',
    noremap = true,
    silent = true,
  })

  map('v', keymaps.range_move_and_transform_jsdoc, module.range_move_and_transform_jsdoc, {
    desc = 'Move Trailing comment and Comment case as JSDoc selected lines',
    noremap = true,
    silent = true,
  })

  map('n', keymaps.move_and_transform_single, module.move_and_transform_single, {
    desc = 'Move Trailing comment and Comment case as single line all lines',
    noremap = true,
    silent = true,
  })

  map('v', keymaps.range_move_and_transform_single, module.range_move_and_transform_single, {
    desc = 'Move Trailing comment and Comment case as single line selected lines',
    noremap = true,
    silent = true,
  })
end

return M
