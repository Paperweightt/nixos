return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require('render-markdown').setup {
      completions = { blink = { enabled = true } },
      heading = {
        width = 'block',
        right_pad = 1,
      },
      code = {
        border = 'thick',
        width = 'block',
        right_pad = 4,
      },
      sign = { enabled = false },
      checkbox = {
        unchecked = {
          icon = '󰄱',
          highlight = 'RenderMarkdownUnchecked',
          scope_highlight = nil,
        },
        checked = {
          icon = '󰱒',
          highlight = 'RenderMarkdownChecked',
          scope_highlight = nil,
        },
      },
    }
  end,
}
