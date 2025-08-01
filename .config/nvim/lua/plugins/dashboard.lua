local header = {
  '                                 ',
  '                                 ',
  '┏┳┓┓┏┏┓┳┓┏┓┳┓┏┓┓┏┓┏┓┳┓┏┓┏┓┏┳┓┏┓┳┓',
  ' ┃ ┣┫┣ ┃┃┣ ┣┫┃┃┗┫┃┫ ┣┫┣┫┣  ┃ ┣ ┣┫',
  ' ┻ ┛┗┗┛┻┛┗┛┛┗┣┛┗┛┛┗┛┛┗┛┗┻  ┻ ┗┛┛┗',
  '                                 ',
  '                                 ',
}

return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      vim.keymap.set(
        'n',
        '<leader>;',
        '<cmd>Dashboard<CR>',
        { desc = 'Dashboard' }
      )
      require('dashboard').setup({
        theme = 'doom',
        config = {
          vim.api.nvim_set_hl(0, 'DashboardHeader', { link = 'FloatTitle' }),
          vim.api.nvim_set_hl(0, 'DashboardIcon', { link = 'DiagnosticInfo' }),
          vim.api.nvim_set_hl(0, 'DashboardDesc', { link = 'Label' }),
          vim.api.nvim_set_hl(0, 'DashboardKey', { link = 'Identifier' }),
          vim.api.nvim_set_hl(0, 'DashboardFooter', { link = 'Function' }),
          header = header, -- change header here
          center = {
            {
              icon = '󰺲  ',
              desc = 'Edit Todo list',
              key = 'T',
              key_format = ' %s',
              action = 'edit ~/Todo.md',
            },
            {
              icon = '  ',
              desc = 'Recent Files',
              key = 'r',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'Telescope oldfiles',
            },
            {
              icon = '  ',
              desc = 'New Empty Buffer',
              key = 'f',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'enew',
            },
            {
              icon = '  ',
              desc = 'Find Text in Workspace',
              key = 't',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'Telescope live_grep',
            },
            {
              icon = '󱘢  ',
              desc = 'Find Git Files in Workspace',
              key = 'g',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'Telescope git_files',
            },
            {
              icon = '󰒲  ',
              desc = 'Lazy Package Manager',
              key = 'l',
              key_format = ' %s', -- remove default surrounding `[]`
              action = 'Lazy',
            },
            {
              icon = '  ',
              desc = 'Desktop Notes',
              key = 'n',
              key_format = ' %s', -- remove default surrounding `[]`
              -- action = "lua require'telescope.builtin'.find_files({})",
              action = 'Oil ~/Documents/Notes',
            },
            {
              icon = '  ',
              desc = 'Termux Notes',
              key = 'N',
              key_format = ' %s', -- remove default surrounding `[]`
              -- action = "lua require'telescope.builtin'.find_files({})",
              action = 'Oil ~/storage/shared/Documents/Notes',
            },
            {
              icon = '  ',
              desc = 'NeoVim Config',
              key = 'c',
              key_format = ' %s', -- remove default surrounding `[]`
              --action = 'Telescope find_files cwd=~/.config/nvim',
              action = 'lua require("oil").open(vim.fn.stdpath("config"))',
            },
            {
              icon = '󰩈  ',
              desc = 'Quit NeoVim',
              key = 'q',
              key_format = ' %s',
              action = 'qa',
            },
            {
              icon = '󰩈  ',
              desc = 'Close dashboard',
              key = 'Q',
              key_format = ' %s',
              action = 'b#',
            },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              '',
              '⌛'
                .. stats.loaded
                .. '/'
                .. stats.count
                .. ' plugins'
                .. '⌛',
              'loaded in ' .. ms .. 'ms',
            }
          end, --your footer
        },
      })
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
}
