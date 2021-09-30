-------------
-- Aliases --
-------------

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.opt

-------------
-- Options --
-------------

o.completeopt = 'menuone,noinsert,noselect'
o.cursorline = true
o.expandtab = true
o.inccommand = 'nosplit'
o.mouse = 'a'
o.number = true
o.relativenumber = true
o.scrolloff = 1
o.shiftwidth = 4
o.shortmess = o.shortmess + 'c'
o.showmode = false
o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.tabstop = 4
o.termguicolors = true
o.undofile = true
o.updatetime = 100

--------------
-- Mappings --
--------------

-- Leader

g.mapleader = ' '

-- Copy and paste with system clipboard

map('v', '<C-c>', '"+y',    {noremap = true})
map('i', '<C-v>', '<C-r>+', {noremap = true})

-- Replace

map('n', '<LEADER>r', ':%s///g<LEFT><LEFT>',  {noremap = true})

-------------
-- Plugins --
-------------

-- Auto install plugin manager

local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..install_path)
end

cmd 'packadd paq-nvim'
local plug = require('paq-nvim').paq

-- Let the plugin manager manage itself

plug {'savq/paq-nvim', opt=true}

-- Plugin list

plug {'nvim-lua/plenary.nvim'}
plug {'nvim-treesitter/nvim-treesitter'}
plug {'phaazon/hop.nvim'}
plug {'tpope/vim-commentary'}
plug {'tpope/vim-fugitive'}
plug {'tpope/vim-surround'}
plug {'nvim-telescope/telescope.nvim'}
plug {'p00f/nvim-ts-rainbow'}
plug {'lukas-reineke/indent-blankline.nvim'}

-- Auto install and clean plugins

require('paq-nvim').install()
require('paq-nvim').clean()

-- Theme

-- cmd 'autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE'
-- cmd 'colorscheme delek'

-- treesitter/rainbow

require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {}, -- table of hex strings
    termcolors = {} -- table of colour name strings
  }
}

-- indent_blankline
o.list = true
o.listchars:append("eol:↴")

require("indent_blankline").setup {
    buftype_exclude = {"terminal"},
    show_end_of_line = true,
}
