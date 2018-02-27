set rtp+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/indentLine.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'fatih/vim-go'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'racer-rust/vim-racer'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'vim-scripts/ag.vim'
"NeoBundle 'xolox/vim-lua-ftplugin'
"NeoBundle 'xolox/vim-misc'
NeoBundle 'tomasr/molokai'
NeoBundle 'freeo/vim-kalisi'
NeoBundle 'zchee/deoplete-go'
NeoBundle 'Shougo/deoplete.nvim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
"NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'sgur/unite-qf'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'davidhalter/jedi-vim'
call neobundle#end()

filetype plugin indent on
filetype plugin on

NeoBundleCheck

"set list lcs=tab:>-,trail:-
set nu
set relativenumber
set cindent
set smartindent
set showmatch
set ignorecase smartcase
set nowrapscan
set incsearch
set magic
set sm
set cmdheight=1
set clipboard+=unnamedplus
set foldcolumn=2
set foldmethod=indent
set foldlevel=5
set mouse=a
syntax on
colorscheme kalisi
set background=dark

set sw=4
set tabstop=4
set softtabstop=4
let mapleader=" "

imap jk <esc>
"map <silent> <leader>ss :source ~/.config/nvim/init.vim<cr>
"map <silent> <leader>ee :e ~/.config/nvim/init.vim<cr>
nmap <leader>h <c-w>h
nmap <leader>l <c-w>l
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>H <c-w>H
nmap <leader>L <c-w>L
nmap <leader>J <c-w>J
nmap <leader>K <c-w>K
map  / <Plug>(easymotion-sn)
nmap s <Plug>(easymotion-s)
nmap <leader>1 <Plug>AirlineSelectTab1<cr>
nmap <leader>2 <Plug>AirlineSelectTab2<cr>
nmap <leader>3 <Plug>AirlineSelectTab3<cr>
nmap <leader>4 <Plug>AirlineSelectTab4<cr>
nmap <leader>5 <Plug>AirlineSelectTab5<cr>
nmap <leader>6 <Plug>AirlineSelectTab6<cr>
nmap <leader>7 <Plug>AirlineSelectTab7<cr>
nmap <leader>8 <Plug>AirlineSelectTab8<cr>
nmap <leader>9 <Plug>AirlineSelectTab9<cr>

let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1


"syntastic{
let g:syntastic_python_checkers=['flake8']
"let g:ycm_show_diagnostics_ui = 0
"let g:syntastic_aggregate_errors = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_style_error_symbol = "✗="
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_style_error_symbol = "⚠="
let g:syntastic_auto_jump = 0
"}

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_min_count = 2
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'

highlight  CursorLine ctermbg=Green ctermfg=None
autocmd InsertEnter * highlight  CursorLine ctermbg=blue ctermfg=Red
autocmd InsertLeave * highlight  CursorLine ctermbg=Green ctermfg=None

let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_structs = 1
let g:go_highlight_methods = 1

set hidden
let $RUST_SRC_PATH="/Users/lucas/code/rust/rust-master/src"
let g:racer_cmd = "/Users/lucas/.cargo/bin/racer"
let g:rustfmt_command = "/Users/lucas/.cargo/bin/rustfmt"
let g:lua_complete_omni = 1
let g:rustfmt_autosave = 1
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:racer_insert_paren = 1
let g:deoplete#sources#go = 'vim-go'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <leader>p :Unite -no-split -start-insert file_rec/neovim<cr>
nnoremap <leader>o :Unite -no-split file_mru<cr>
nnoremap <leader>b :Unite -no-split -start-insert buffer<cr>
"nnoremap <leader>s :Unite -no-split -no-quit -buffer-name="search" grep:.<cr>
nnoremap <leader>i :VimFiler -no-split<cr>
nnoremap <leader>m :VimFiler -no-split bookmark<cr>
nnoremap <leader>q :Unite -no-split qf<cr>
noremap <leader>s :Ag! <c-r><c-w>
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

if has('nvim')
	tnoremap jk <C-\><C-n>
endif
