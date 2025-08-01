return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({
          async = true,
          lsp_format = 'fallback',
        })
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = true,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 3000,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      zsh = { 'shfmt' },
      bash = { 'shfmt' },
      sh = { 'shfmt' },
      python = { 'black' },
    },
    formatters = {
      -- shfmt = {
      --   inherit = true,
      --   command = 'shfmt',
      --   prepend_args = {
      --     '-i',
      --     '2',
      --     '--apply-ignore',
      --     '-ln=auto',
      --     '-bn',
      --     '-sr',
      --     '-ci',
      --   },
      -- },
    },
  },
}
