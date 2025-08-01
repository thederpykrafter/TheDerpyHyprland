return {
  {
    '2kabhishek/nerdy.nvim',
    -- dependencies = {
    --     '',
    -- },
    cmd = 'Nerdy',
    keys = {
      { '<leader>nn', '<cmd>Nerdy<cr>', desc = 'NerdFont Icon Picker' },
    },
    opts = {
      max_recents = 30, -- Configure recent icons limit
      add_default_keybindings = true, -- Add default keybindings
      use_new_command = true, -- Enable new command system
    },
  },
  {
    'nvim-telescope/telescope-symbols.nvim',
    keys = {
      {
        '<leader>ns',
        '<cmd>Telescope symbols<cr>',
        desc = 'Telescope Symbol Picker',
      },
    },
  },
}
