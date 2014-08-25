if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

set mouse=a
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'ctrlp.vim'
Plugin 'The-NERD-tree'
Plugin 'davidhalter/jedi-vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Lokaltog/vim-powerline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/vimshell.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Shougo/vimproc.vim'
Plugin 'vim-scripts/indentLine.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-git'
call vundle#end()
filetype plugin indent on

set list lcs=tab:>-,trail:-

call pathogen#infect()
call pathogen#helptags()

let g:NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['.pyc$', '\~$']

"powerline{
" set guifont=PowerlineSymbols\ for\ Powerline
 "set nocompatible set t_Co=256
 let g:Powerline_symbols = 'fancy'
"}

set guifont=menlo:h12

"jedi{
"let g:jedi#auto_initialization = 1
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
"let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"
let g:jedi#popup_select_first = 0
"}

"autocmd vimenter * NERDTree

"syntastic{
execute pathogen#infect()
let g:syntastic_python_checkers=['flake8']
let g:ycm_show_diagnostics_ui = 0
"let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = "✗="
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "⚠="
let g:syntastic_auto_jump = 0
"}



set nu
set cindent
set smartindent
set showmatch
set ignorecase smartcase
set nowrapscan
set incsearch
set hlsearch
set magic
set sm
set backspace=indent,eol,start
set cmdheight=1


set laststatus=2
set autoread
"set foldcolumn=2
"set foldmethod=indent 
"set foldlevel=5
syntax on
colorscheme inkpot

set sw=4
set tabstop=4
set softtabstop=4

map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
map <leader>i :NERDTreeToggle <cr>
"map <leader>im :PymodeRopeAutoImport<cr>
nnoremap <leader>wl <c-w>v<c-w>l
nnoremap <leader>w <c-w>w
imap jk <esc>

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)
nmap s <Plug>(easymotion-s)
omap t <Plug>(easymotion-bd-tl)
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
