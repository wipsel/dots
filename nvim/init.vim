" wipsels vim config.
filetype off

" Plug setup
call plug#begin('~/.config/nvim/plugged')

" Linting & completion
Plug 'psf/black', { 'branch': '20.8b1' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'fatih/vim-go'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/0.x'
  \ }

" Highlighting & syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " highlighting
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'embark-theme/vim', {'as': 'embark'}

" Project and file management
Plug 'airblade/vim-gitgutter'

" Easier commenting
Plug 'scrooloose/nerdcommenter'


" Nicer statusline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'romgrk/barbar.nvim'

" Telescope (better Ctrl-P)
Plug 'nvim-lua/popup.nvim'          " popup impl for telescope
Plug 'nvim-lua/plenary.nvim'        " helper functions for telescope
Plug 'kyazdani42/nvim-web-devicons' " nice icons in telescope
Plug 'nvim-telescope/telescope.nvim'

" Plug cleaunup
call plug#end()

"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
let g:gruvbox_italic=1
colorscheme gruvbox


" Lua plugin configs
lua <<EOF
require 'plugins.treesitter'
require 'plugins.telescope'
require 'plugins.lspconfig'
require 'plugins.statusline'
EOF

" nvim-lsp & completion-nvim
set signcolumn=no
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set updatetime=300


autocmd BufEnter * lua require'completion'.on_attach()
autocmd CursorHold * silent lua vim.lsp.buf.hover()

"use tab for autocomplete selection.
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.hover()<CR>

" Telescope
nnoremap <silent> <Space>p <cmd>Telescope find_files<CR>
nnoremap <silent> <Space>o <cmd>Telescope live_grep<CR>
nnoremap <silent> <C-s> <cmd>Telescope current_buffer_fuzzy_find<CR>
nnoremap <silent> <C-b> <cmd>Telescope buffer<CR>
nnoremap <silent> <leader>b <cmd>Telescope buffers<CR>

" Fixers (black, prettier, goimports)
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePre *.ts execute ':PrettierAsync'
autocmd BufWritePre *.js execute ':PrettierAsync'
autocmd BufWritePre *.scss execute ':PrettierAsync'
autocmd BufWritePre *.css execute ':PrettierAsync'
let g:prettier#quickfix_enabled = 0
let g:go_fmt_command = "goimports"
nmap <Leader>py <Plug>(Prettier)

" a lot of sain defaults
set grepprg=rg
set cursorline
set hidden
set background=dark
set number
set foldmethod=indent
set list
set listchars=tab:>-
set foldlevel=99
set colorcolumn=100
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=8
set modeline
set wrap
set nobackup
set nowb
set noswapfile
set encoding=utf-8


syntax enable
filetype plugin on
set nocompatible

if (has("termguicolors"))
   set termguicolors
endif

" Ignore uneccessary files
set wildignore+=__pycache__
set wildignore+=*.pyc
set wildignore+=node_modules
set wildignore+=*/app/cache/*
set wildignore+=*/vendor/*
set wildignore+=*/.git/*
set wildignore+=*/tmp/*
set wildignore+=*.swp


" Disable arrow keys
map <Up> <NOP>
map <Down> <NOP>
map <Left> <NOP>
map <Right> <NOP>
map <Del> <Nop>

" Map Leader key to Ctrl-w. This allows buffer switching with Leader-h|j|k|l.
map <leader> <C-w>

" Leave insert mode by pressing jj.
imap jj <ESC>

" Save file in normal mode by pressing Enter
nnoremap <CR> :w<CR>

" Remove trailing white space on save.
autocmd BufWritePre * :%s/\s\+$//e

syntax on
let python_highlight_all=1


"Map Leader to space bar
let mapleader = "\<Space>"


"buffers
"left buffer
noremap  <leader>h <Esc>:bp<CR>
"right buffer
noremap  <leader>l <Esc>:bn<CR>
"close buffer
noremap  <leader>j <Esc>:bd<CR>

"CLIPBOARD requires some kind of clipboard tool like xclip
" Copy to clipboard.
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy
" Paste from clipboard.
nnoremap <leader>v "+p
nnoremap <leader>V "+P
vnoremap <leader>v "+p
vnoremap <leader>V "+P


