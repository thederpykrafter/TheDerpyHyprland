require('core.bootstrap-lazy')
require('core.options')
require('core.keymaps')
require('core.usercmd')
require('core.filetypes')

require('lazy').setup({
  spec = {
    { import = 'plugins' },
  },
  install = { colorscheme = { 'habamax' } },
  checker = { enabled = true },
  change_detection = {
    enabled = true,
    notify = true,
  },
})

local checker = require('lazy.manage.checker')
---@diagnostic disable-next-line: duplicate-set-field, unused-local
checker.report = function(notify) end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
