-- main module file
local module = require('ts_comment_case.module')
local keymaps = require('ts_comment_case.keymaps')

---@class Config
---@field opt string Your config option
local config = {
  plugin_dir = '',
  keymaps = {
    transform_jsdoc = '<leader>cctj',
    range_transform_jsdoc = '<leader>cctj',
    transform_single = '<leader>ccts',
    range_transform_single = '<leader>ccts',

    move_trailing_comment_to_leading = '<leader>ccm',
    range_move_trailing_comment_to_leading = '<leader>ccm',

    move_and_transform_jsdoc = '<leader>ccxj',
    range_move_and_transform_jsdoc = '<leader>ccxj',
    move_and_transform_single = '<leader>ccxs',
    range_move_and_transform_single = '<leader>ccxs',
  },
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend('force', M.config, args or {})

  if string.len(M.config.plugin_dir) == 0 then
    M.config.cmd = 'tscc'
  else
    M.config.cmd = M.config.plugin_dir .. '/node_modules/.bin/tscc'
  end

  module.setup({
    cmd = M.config.cmd,
  })
  keymaps.setup(M.config.keymaps)
end

return M
