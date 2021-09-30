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
-- windows
map('v', '<C-c>', '"+y',    {noremap = true})
map('i', '<C-v>', '<C-r>+', {noremap = true})
-- mac
if vim.fn.has('macunix') == 1 then
    map('v', '<D-c>', '"+y',    {noremap = true})
    map('i', '<D-v>', '<C-r>+', {noremap = true})
end

-- Replace

map('n', '<LEADER>r', ':%s///g<LEFT><LEFT>',  {noremap = true})

-- switch tabs

map('n', 'H', 'gT', {})
map('n', 'L', 'gt', {})


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
-- plug {'yggdroot/indentline'}
plug {'jacoborus/tender.vim'}
plug {'khaveesh/vim-fish-syntax'}
plug {'lewis6991/gitsigns.nvim'}  -- Needs plenary.vim
-- plug {'numToStr/FTerm.nvim'}
plug {'numtostr/FTerm.nvim'}

-- Auto install and clean plugins

require('paq-nvim').install()
require('paq-nvim').clean()

-- Theme

-- cmd 'autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE'
-- cmd 'colorscheme delek'

-- treesitter/rainbow

-- require'nvim-treesitter.configs'.setup {
--   rainbow = {
--     enable = true,
--     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
--     max_file_lines = nil, -- Do not enable for files with more than n lines, int
--     colors = {}, -- table of hex strings
--     termcolors = {} -- table of colour name strings
--   }
-- }
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {  }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
-- indent_blankline
 o.list = true
 -- o.listchars:append("eol:↴")

 require("indent_blankline").setup {
     char = '|',
     buftype_exclude = {"terminal"},
     show_end_of_line = false,
 }

 -- gitsigns
 
 require('gitsigns').setup()

 -- Fterm
 
 require'FTerm'.setup({
     border = 'double',
     dimensions  = {
         height = 0.9,
         width = 0.9,
     },
 })
 local opts = { noremap = true, silent = true }

if vim.fn.has('macunix') == 1 then
    map('n', '<D-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
    map('t', '<D-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
else
    map('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
    map('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)
end
