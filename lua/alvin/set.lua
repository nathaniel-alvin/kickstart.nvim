-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.opt.guicursor = ""

-- Make relative line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = 4
vim.o.expandtab = true

-- Enable auto indenting and set it to spaces
vim.o.smartindent = true
vim.o.shiftwidth = 4

-- Enable break indent (smart indenting) https://stackoverflow.com/questions/1204149/smart-wrap-in-vim
vim.o.breakindent = true

-- Disable text wrap
vim.o.wrap = false

-- Better splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = "unnamed,unnamedplus"

-- Save undo history
vim.o.undofile = true

-- Set highlight on search and incremental searching
vim.o.hlsearch = false
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.o.incsearch = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = '┊ ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.colorcolumn = "120"
