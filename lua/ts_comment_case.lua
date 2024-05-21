-- main module file
local module = require("ts_comment_case.module")

---@class Config
---@field opt string Your config option
local config = {
  plugin_dir = "",
}

---@class MyModule
local M = {}

---@type Config
M.config = config

---@param args Config?
-- you can define your setup function here. Usually configurations can be merged, accepting outside params and
-- you can also put some validation here for those.
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})

  if string.len(M.config.plugin_dir) == 0 then
    M.config.cmd = "tscc"
  else
    M.config.cmd = M.config.plugin_dir .. "/node_modules/.bin/tscc"
  end

  -- set keymaps
  vim.keymap.set("n", "<leader>tscc", '<cmd>lua require("ts_comment_case").tscc_replace_all()<CR>', {
    desc = "Comment case as JSDoc all lines",
    noremap = true,
    silent = true,
  })

  vim.keymap.set("v", "<leader>tscc", '<cmd>lua require("ts_comment_case").tscc_replace_range()<CR>', {
    desc = "Comment case as JSDoc selected lines",
    noremap = true,
    silent = true,
  })
end

M.tscc_replace_all = function(opts)
  return module.tscc_replace_all({ cmd = M.config.cmd }, opts)
end

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

M.tscc_replace_range = function(opts)
  return module.tscc_replace_range({ cmd = M.config.cmd }, opts)
end

return M
