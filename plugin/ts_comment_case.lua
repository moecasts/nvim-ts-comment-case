local module = require('ts_comment_case.module')

local set_commands = function()
  vim.api.nvim_create_user_command('TSCCTransformJSDoc', module.transform_jsdoc, {})
  vim.api.nvim_create_user_command('TSCCRangeTransformJSDoc', module.range_transform_jsdoc, {
    range = true,
  })
  vim.api.nvim_create_user_command('TSCCTransformSingle', module.transform_single, {})
  vim.api.nvim_create_user_command('TSCCRangeTransformSingle', module.range_transform_single, {
    range = true,
  })

  vim.api.nvim_create_user_command('TSCCMove', module.move_trailing_comment_to_leading, {})
  vim.api.nvim_create_user_command('TSCCRangeMove', module.move_trailing_comment_to_leading, {
    range = true,
  })

  vim.api.nvim_create_user_command('TSCCMoveTransformJSDoc', module.move_and_transform_jsdoc, {})
  vim.api.nvim_create_user_command('TSCCRangeMoveTransformJSDoc', module.range_move_and_transform_jsdoc, {
    range = true,
  })
  vim.api.nvim_create_user_command('TSCCMoveTransformSingle', module.move_and_transform_single, {})
  vim.api.nvim_create_user_command('TSCCRangeMoveTransformSingle', module.range_move_and_transform_single, {
    range = true,
  })
end

set_commands()
