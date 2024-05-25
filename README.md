# nvim-ts-comment-case

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/moecasts/nvim-ts-comment-case/lint-test.yml?branch=main&style=for-the-badge)
![Lua](https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua)

A Neovim plugin to change `js/ts` comment into `JSDoc` style.

## Installation

- With `lazy.nvim`:

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

## Configuration

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

### Plugin Spec

| Property   | Type     | Description                                                                                                          |
| ---------- | -------- | -------------------------------------------------------------------------------------------------------------------- |
| plugin_dir | string?  | the plugin directory, a npm package [`tscc`](https://github.com/moecasts/ts-comment-case) will be installed in there |
| keymaps    | Keymaps? | the keymaps of the plugin actions                                                                                    |

### Default Configuration

```lua
{
  config = function(plugin)
    require('ts_comment_case').setup({
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
    })
  end,
},
```


## Features

### Keys

- `<leader>cctj`: Comment case as JSDoc
- `<leader>ccts`: Comment case as single line

- `<leader>ccm`: Move tailing comment to leading comment

- `<leader>ccxj`: Move Trailing comment and Comment case as JSDoc
- `<leader>ccxs`: Move Trailing comment and Comment case as single line

### Commands

- `TSCCTransformJSDoc`: Comment case as JSDoc all lines
- `TSCCRangeTransformJSDoc`: Comment case as JSDoc selected lines
- `TSCCTransformSingle`: Comment case as single line all lines
- `TSCCRangeTransformSingle`: Comment case as single line selected lines
- `TSCCMove`: Move tailing comment to leading comment all lines
- `TSCCRangeMove`: Move tailing comment to leading comment selected lines
- `TSCCMoveTransformJSDoc`: Move Trailing comment and Comment case as JSDoc all lines
- `TSCCRangeMoveTransformJSDoc`: Move Trailing comment and Comment case as JSDoc selected lines
- `TSCCMoveTransformSingle`: Move Trailing comment and Comment case as single line all lines
- `TSCCRangeMoveTransformSingle`: Move Trailing comment and Comment case as single line selected lines

## Related

- [ts-comment-case](https://github.com/moecasts/ts-comment-case)
- [vscode-ts-comment-case](https://github.com/moecasts/vscode-ts-comment-case)
