-- also set in plugins/treesitter.lua
vim.filetype.add({
  extension = {
    -- c3 filetypes
    c3 = 'c3',
    c3i = 'c3',
    c3t = 'c3',
  },
})
-- set filetype for i3config files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('i3_config_detection', { clear = true }),
  pattern = { '*/i3/config', '*/i3/config.d/*', '*/i3/*.config' },
  command = 'set filetype=i3config',
})

-- set filetype for i3config files
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vim.api.nvim_create_augroup('set_license_filetype', { clear = true }),
  pattern = { '*/LICENSE', '*/LICENSE.md' },
  command = 'set filetype=markdown',
})
