return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  lazy = false,
  cmd = {
    'TodoTelescope',
    'TodoLocList',
  },
  keys = {
    {
      '<leader>st',
      '<cmd>TodoTelescope<cr>',
      desc = '[S]earch [T]odo Telescope',
    },
    {
      '<leader>sl',
      '<cmd>TodoLocList<cr>',
      desc = '[S]earch [T]odo [L]ocList',
    },
  },
}
-- TODO:
