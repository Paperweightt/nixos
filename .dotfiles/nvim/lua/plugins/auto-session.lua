vim.opt.sessionoptions = {
  'blank',
  'buffers',
  'curdir',
  'folds',
  'help',
  'tabpages',
  'winsize',
  'winpos',
  'terminal',
  'localoptions',
}

vim.keymap.set('n', '<leader>sa', '<cmd>SessionSearch<CR>', { desc = '[S]earch [A]uto Sessions' })

return {
  'Paperweightt/auto-session',
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      auto_restore_last_session = true,
      auto_save = true,
      use_git_branch = true,
    }
  end,
}
