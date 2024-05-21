# nvim-ts-comment-case

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/moecasts/nvim-ts-comment-case/lint-test.yml?branch=main&style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)

A Neovim plugin to change `js/ts` comment into `JSDoc` style.

## Using it

using `lazy.nvim`:

```lua
return {
  -- change ts comment case
  {
    'moecasts/nvim-ts-comment-case',
    build = function(plugin)
      os.execute(string.format('cd %s && npm i --no-save', plugin.dir))
    end,
    config = function(plugin)
      require('ts_comment_case').setup({
        plugin_dir = plugin.dir,
      })
    end,
  },
}
```

## Features and structure

- 100% Lua
- Github actions for:
  - running tests using [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) and [busted](https://olivinelabs.com/busted/)
  - check for formatting errors (Stylua)
  - vimdocs autogeneration from README.md file
  - luarocks release (LUAROCKS_API_KEY secret configuration required)

### Plugin structure

```
.
├── lua
│   ├── ts_comment_case
│   │   └── module.lua
│   └── ts_comment_case.lua
├── Makefile
├── plugin
│   └── ts_comment_case.lua
├── README.md
├── tests
│   ├── minimal_init.lua
│   └── ts_comment_case
│       └── ts_comment_case_spec.lua
```
