-- leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.opt.mouse = 'a'

vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.swapfile = false

-- fold
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'

-- tabbing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2   -- Number of spaces for each indentation level
vim.opt.tabstop = 2      -- Number of spaces per tab
vim.opt.softtabstop = 2  -- Makes backspace delete like a tab

-- visuals
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 12
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.laststatus = 0

vim.opt.fillchars = 'eob: '
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>rl', function()
  local ok, err = pcall(dofile, vim.fn.expand '%')
  if not ok then
    vim.notify('Lua Error:\n' .. err, vim.log.levels.ERROR)
  else
    vim.notify('Lua file executed successfully', vim.log.levels.INFO)
  end
end, { desc = 'Run current Lua file with error reporting' })

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'resize splits',
  callback = function()
    vim.cmd 'wincmd ='
  end,
})

-- Ctrl+S to save the file
-- vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
-- vim.keymap.set('i', '<C-s>', function()
--   vim.cmd 'w'
-- end, { noremap = true, silent = true })

vim.keymap.set('v', '<leader>r', function()
  -- Get the selected text
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'x', false)

  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  -- Extract the selected text
  local selected_text
  if #lines == 1 then
    -- Single-line selection
    selected_text = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    selected_text = table.concat(lines, '\n')
  end

  -- Print or process the selected text
  print(selected_text)

  -- Prompt for replacement text
  local replacement = vim.fn.input('Replace"' .. selected_text .. '" with? ')
  if replacement ~= '' then
    -- Execute the substitution
    vim.cmd('%s/\\V' .. vim.fn.escape(selected_text, '\\') .. '/' .. vim.fn.escape(replacement, '\\') .. '/g')
  end
end, {
  desc = '[R]eplace visual selection',
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-sleuth',
  'numToStr/Comment.nvim',

  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode',        mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>z', group = '[Z]ettelkasten' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk',    mode = { 'n', 'v' } },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ['<C-d>'] = 'delete_buffer', -- delete in insert mode
            },
            n = {
              ['<C-d>'] = 'delete_buffer', -- delete in normal mode
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = 'C:\\Users\\henry\\.dotfiles\\nvim' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        rust = { 'rustfmt' },
        json = { 'prettierd' },
        yaml = { 'prettierd' },
        markdown = { 'prettierd' },
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        css = { 'prettierd' },
        html = { 'prettierd' },
      },
    },
  },
  { 'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'rust',
          'c',
          'html',
          'css',
          'lua',
          'powershell',
          'markdown_inline',
          'markdown',
          'jsdoc',
          'javascript',
          'gitignore',
          'yaml',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  { import = 'plugins' },
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤',
    },
  },
}

require 'neovide'
require 'lsp'
require 'zettelkasten'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
