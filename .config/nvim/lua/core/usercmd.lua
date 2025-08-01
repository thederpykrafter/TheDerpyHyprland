local usercmd = vim.api.nvim_create_user_command

usercmd('Q', 'q', { desc = 'Quit' })
usercmd('W', 'w', { desc = 'Write to file' })
usercmd('WQ', 'wq', { desc = 'Write to file & Quit' })
usercmd('Wq', 'wq', { desc = 'Write to file & Quit' })
usercmd('WA', 'wa', { desc = 'Write to all files' })
usercmd('Wa', 'wa', { desc = 'Write to all files' })
