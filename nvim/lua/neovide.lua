if vim.g.neovide then
  local display_mode = false
  local default_font = 'FiraCode Nerd Font Mono:h11'
  local display_font = 'FiraCode Nerd Font Mono:h15.5'

  vim.g.neovide_opacity = 0
  vim.g.neovide_transparency = 0.80
  vim.g.neovide_cursor_animation_length = 0.015
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_scale_factor = 1
  vim.o.guifont = default_font

  vim.keymap.set('n', '<leader>td', function()
    if display_mode then
      display_mode = false
      vim.o.guifont = default_font
    else
      display_mode = true
      vim.o.guifont = display_font
    end
  end, { desc = '[T]oggle [D]isplay mode' })

  local function sync_separator_with_background()
    local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg
    vim.api.nvim_set_hl(0, 'WinSeparator', {
      fg = '#83a598',
      bg = normal_bg and string.format('#%06x', normal_bg) or 'NONE',
    })
  end

  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = sync_separator_with_background,
  })

  sync_separator_with_background()
end
