return {
  "paperweightt/transmute.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    local transmute = require("transmute")

    transmute.setup()

    vim.keymap.set('v', '<leader>tf', transmute.transmute_from_to, { desc = '[T]ransmute [F]rom to' })
    vim.keymap.set('v', '<leader>tt', transmute.transmute_to, { desc = '[T]ransmute [T]o' })
  end,
}
