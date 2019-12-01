""" VIM configuration file.
" This file assumes that you use neovim (https://neovim.io/).
" 
" It lives at '~/.config/nvim/init.vim'. For convenience, you may want to
" create a symlink: `ln -sf ~/.config/nvim/init.vim ~/.vimrc`

"" Plugin manager.
"
" NOTE: After adding a new plugin, you need to source the init.vim file (or restart vim).
"
" To install plugins: `:PlugInstall`
" To update plugins: `:PlugUpdate`

call plug#begin('~/.config/nvim/plugins')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'scrooloose/nerdtree'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'skywind3000/asyncrun.vim'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'terryma/vim-multiple-cursors'
call plug#end()


"" General config
" Tabs are 4 space characters and are entered with tab key
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Remap keys for switching between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

set splitbelow
set splitright

" clear highlighting with ESC key
nnoremap <CR> :noh<CR><CR>

" toggle line numbers
map <C-\> :set number!<CR>

" Comment line (based on vim-commentary plugin)
map <C-_> :Commentary<CR>

" Remap leader key to spacebar to both hands can hit it
let mapleader = ' '

" Yank to system clipboard (and paste from it)
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


"" Multiple cursors config
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<A-d>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<A-d>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"" NERDTree config
" Toggle NERDTree by pressing Alt+t
map <A-t> :NERDTreeToggle<CR>
" If NERDTree is only remaining split open, close nvim entirely.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"" Configure gruvbox theme
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 1
colorscheme gruvbox

"" Configure syntax highlighting and code checking
" Configure Ale with ESLint
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'
let g:ale_lint_on_enter = 0
nmap <silent> <leader>ae :ALENext<cr>
nmap <silent> <leader>ap :ALEPrevious<cr>
" Configure ESLint to run on JSX files when file is saved
autocmd BufWritePost *.jsx AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %
" Set tabs to 2 spaces for JSX files
filetype plugin on
autocmd FileType javascript setlocal tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

"" CTags
" Configure Vim to find tag files. Vim will search for a .tags file in the
" directory of the current file, in the current directory, and up and up until
" the $HOME directory, stopping on the first hit.
set tags=./tags,.tags;$HOME
