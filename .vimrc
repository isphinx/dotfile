filetype plugin indent on
filetype plugin on

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

"set clipboard+=unnamedplus
"set foldcolumn=2
"set foldmethod=indent
"set foldlevel=5
set mouse=a
set sw=4
set tabstop=4
set softtabstop=4
set hlsearch

syntax on
set laststatus=2
set background=light
let g:solarized_termcolors=256
let g:solarized_contrast = "high"
"let g:solarized_visibility= "high"
colorscheme solarized
let g:rainbow_active = 1
let mapleader=" "
let termdebugger = "lldb"

imap jl <esc>
map <silent> <leader>ss :source ~/.vimrc<cr>
map <silent> <leader>ee :e ~/.vimrc<cr>
map <silent> <leader>w :w<cr>
map <silent> <leader>d :bd<cr>
nmap <leader>h <c-w>h
nmap <leader>l <c-w>l
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>H <c-w>H
nmap <leader>L <c-w>L
nmap <leader>J <c-w>J
nmap <leader>K <c-w>K
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
map  / <Plug>(easymotion-sn)
nmap s <Plug>(easymotion-s)
nmap <leader>bd :set bg=dark<cr>
nmap <leader>bl :set bg=light<cr>
nmap <leader>t :terminal ++curwin<cr>
tnoremap jl <C-W>N

let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1


"syntastic{
"let g:syntastic_python_checkers=['flake8']
"let g:ycm_show_diagnostics_ui = 0
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_error_symbol = "✗"
"let g:syntastic_style_error_symbol = "✗="
"let g:syntastic_warning_symbol = "⚠"
"let g:syntastic_style_error_symbol = "⚠="
"let g:syntastic_auto_jump = 0
"}

highlight  CursorLine ctermbg=Green ctermfg=None
autocmd InsertEnter * highlight  CursorLine ctermbg=blue ctermfg=Red
autocmd InsertLeave * highlight  CursorLine ctermbg=Green ctermfg=None

"let g:go_highlight_operators = 1
"let g:go_highlight_functions = 1
"let g:go_highlight_structs = 1
"let g:go_highlight_methods = 1

set hidden

"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" nnoremap <leader>p :Files<cr>
" nnoremap <leader>g :GFiles<cr>
" nnoremap <leader>gs :GFiles?<cr>
" nnoremap <leader>o :History<cr>
" nnoremap <leader>r :Rg <c-r><c-w><cr>
" nnoremap <leader>b :Buffers<cr>
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)


let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }
set completeopt-=preview
set completeopt+=longest,menuone,noselect
let g:LanguageClient_autoStart = 1
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> rn :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>f :call LanguageClient_textDocument_formatting()<CR>


" let g:LanguageClient_loggingFile = expand('~/LanguageClient.log')

let g:syntastic_enable_balloons = 1

let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
let g:Lf_ShortcutB = "fb"
noremap fm :<C-U><C-R>=printf("Leaderf! mru %s", "")<CR><CR>
" noremap fl :<C-U><C-R>=printf("Leaderf! line %s", expand("<cword>"))<CR>
noremap fl :<C-U><C-R>=printf("Leaderf! line %s", expand("<cword>"))<CR>

" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
noremap <C-B> :Leaderf! rg --current-buffer <c-r><c-w><CR>
noremap <C-F> :Leaderf! rg -e <c-r><c-w><CR>
noremap fr :LeaderfRgRecall<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR><CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

let g:Lf_PreviewResult = {
		\ 'File': 1,
		\ 'Buffer': 0,
		\ 'Mru': 0,
		\ 'Tag': 0,
		\ 'BufTag': 1,
		\ 'Function': 1,
		\ 'Line': 0,
		\ 'Colorscheme': 1,
		\ 'Rg': 1,
		\ 'Gtags': 0
		\}

