vim.o.shell = 'pwsh'
vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
vim.o.shellquote = '"'
vim.o.shellxquote = ''
vim.o.shellpipe = '| Out-File -Encoding UTF8 -Append'
vim.o.shellredir = '| Out-File -Encoding UTF8'

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
  prev_buf = {
    path = nil,
  },
}

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'resize float terminal',
  callback = function()
    if state.floating.buf == vim.api.nvim_get_current_buf() then
      local width = math.floor(vim.o.columns * 0.8)
      local height = math.floor(vim.o.lines * 0.8)
      local col = math.floor((vim.o.columns - width) / 2)
      local row = math.floor((vim.o.lines - height) / 2)

      vim.api.nvim_win_set_config(state.floating.win, {
        relative = 'editor', -- or "win", "cursor" etc, depending what you want
        row = row,           -- new vertical position
        col = col,           -- new horizontal position
        width = width,
        height = height,
        style = 'minimal', -- No borders or extra UI elements
        border = 'rounded',
      })
    end
  end,
})


vim.keymap.set('t', '<C-h>', function()
  local term_buf = state.floating.buf
  local chan_id = vim.b[term_buf].terminal_job_id
  local path = state.prev_buf.path
  local prefix = 'oil'

  if not path then
    return
  end

  if string.sub(path, 1, #prefix) == prefix then
    path = 'C:' .. string.sub(path, 9)
  end

  vim.fn.chansend(chan_id, { 'cd "' .. path .. '"\r\n' })
end, { noremap = true, silent = true })

vim.keymap.set('t', '<C-n>', function()
  local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer

  vim.api.nvim_win_set_buf(state.floating.win, buf)
  state.floating.buf = buf

  vim.cmd.terminal()
end, { noremap = true, silent = true })

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal', -- No borders or extra UI elements
    border = 'rounded',
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_terminal()
  state.prev_buf.path = vim.fn.expand '%:p:h'
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.keymap.set('n', '<C-p>', function()
  vim.cmd 'startinsert'
  toggle_terminal()

  local term_buf = state.floating.buf
  local chan_id = vim.b[term_buf].terminal_job_id

  if vim.o.shell == 'pwsh' or vim.o.shell == 'powershell' then
    vim.fn.chansend(chan_id, { 'Invoke-Expression (Get-History)[-1].CommandLine\r\n' })
  else
    vim.fn.chansend(chan_id, { '\x1b[A' })
  end
end, { noremap = true, silent = true, desc = 'run most recent shell command' })

-- Map Ctrl-t in normal and terminal modes
vim.keymap.set('n', '<C-t>', function()
  vim.cmd 'startinsert'
  toggle_terminal()
end, { desc = '[T]oggle Terminal' })
vim.keymap.set('t', '<C-t>', function()
  vim.cmd 'stopinsert'
  toggle_terminal()
end, { desc = '[T]oggle Terminal' })

return {}
