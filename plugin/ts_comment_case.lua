vim.api.nvim_create_user_command("TSCCReplaceAll", require("ts_comment_case").tscc_replace_all, {})
vim.api.nvim_create_user_command("TSCCReplaceRange", require("ts_comment_case").tscc_replace_range, {
  range = true,
})
