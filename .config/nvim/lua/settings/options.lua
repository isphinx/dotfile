local apply_options = require("settings.utils").apply_options

apply_options(
  {
    compatible = false,
    wildmenu = true,
    cindent = true,
    autoindent = true, -- enable autoindent
    smartcase = true, -- improve searching using '/'
    smartindent = true, -- smarter indentation
    smarttab = true, -- make tab behaviour smarter
    undofile = true,
    showcmd = false, -- disable mode display since lightline display
    showmatch = true, -- highlight matching [{()}]
    backup = false, -- disable backup
    cursorline = true, -- enable cursorline
    expandtab = true, -- use spaces instead of tabs
    -- autowrite = true, -- autowrite buffer when it's not focused
    hidden = true, -- keep hidden buffers
    hlsearch = true, -- highlight matching search
    ignorecase = true, -- case insensitive on search
    lazyredraw = true, -- lazyredraw to make macro faster
    list = false, -- display listchars
    number = true, -- enable number
    relativenumber = true, -- enable relativenumber
    showmode = false, -- don't show mode
    splitbelow = true, -- split below instead of above
    splitright = true, -- split right instead of left
    startofline = false, -- don't go to the start of the line when moving to another file
    swapfile = false, -- disable swapfile
    termguicolors = true, -- truecolours for better experience
    wrap = false, -- dont wrap lines
    writebackup = false, -- disable backup
    wildignorecase = true,
    ttyfast = true,
    timeout = true,
    ttimeout = true,
    completeopt = "menu,menuone,preview,noinsert,noselect",
    matchpairs = "(:),{:},[:],<:>", -- highlight match pairs
    omnifunc = "v:lua.vim.lsp.omnifunc",
    formatoptions = "1jcroql", -- improve editor formatting
    encoding = "UTF-8", -- set encoding
    inccommand = "split", -- incrementally show result of command
    listchars = "eol:↲,tab:∘\\ ,trail:•", -- set listchars
    mouse = "nv", -- enable mouse support
    shortmess = "filnxtToOFIWc", -- disable some stuff on shortmess
    signcolumn = "yes", -- enable sign column all the time, 4 column
    clipboard = "unnamedplus", -- use system clipboard
    syntax = "on", -- syntax enable
    wildignore = ".lock,.sass-cache,.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**",
    foldtext = "v:lua.folds_render()",
    foldmethod = "syntax",
    laststatus = 2, -- always enable statusline
    pumheight = 20, -- limit completion items
    re = 0, -- set regexp engine to auto
    scrolloff = 8, -- make scrolling better
    sidescroll = 2, -- make scrolling better
    sidescrolloff = 15, -- make scrolling better
    synmaxcol = 500, -- set limit for syntax highlighting in a single line
    shiftwidth = 2, -- set indentation width
    tabstop = 2, -- tabsize
    softtabstop = 2,
    textwidth = 140,
    -- redrawtime = 1500,
    redrawtime = 10000,
    numberwidth = 1,
    timeoutlen = 300, -- faster timeout wait time
    updatetime = 100, -- set faster update time
    ttimeoutlen = 0
  }
)

-- vim.cmd('colorscheme zephyr')
vim.cmd('syntax enable')
vim.cmd('set termguicolors')
--vim.cmd('colorscheme tokyonight')
vim.cmd('set wrap')
vim.cmd('autocmd Filetype php setlocal ts=4 sw=4 sts=0 expandtab')

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

require('nvim-treesitter.configs').setup {
  autopairs = {enable = true},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
}

require('snippets').use_suggested_mappings(true)

require'compe'.setup {
  source = {
      emmet = true
    }
}

require('gitsigns').setup({
	signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAdd'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChange', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDelete', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
})

require("github-theme").setup({ themeStyle = "dimmed" })

-- let g:indent_blankline_char = '▏'
vim.cmd([[
  let g:indent_blankline_char = ' '
  let g:indent_blankline_show_end_of_line = v:true
  let g:indent_blankline_use_treesitter = v:true
  let g:indent_blankline_filetype_exclude = ['help','dashboard','dashpreview','NvimTree','coc-explorer','startify','vista','sagahover']

  hi IndentChar1 guibg=#2E3F00 guifg=#788898 gui=nocombine
  hi IndentChar2 guibg=#003A00 guifg=#788898 gui=nocombine
  hi IndentChar3 guibg=#33003C guifg=#788898 gui=nocombine
  hi IndentChar4 guibg=#002B2F guifg=#788898 gui=nocombine
  hi IndentSpaceChar1 guibg=#2E3F00 gui=nocombine
  hi IndentSpaceChar2 guibg=#003A00 gui=nocombine
  hi IndentSpaceChar3 guibg=#33003C gui=nocombine
  hi IndentSpaceChar4 guibg=#002B2F gui=nocombine

  let g:indent_blankline_char_highlight_list = ['IndentChar1', 'IndentChar2', 'IndentChar3', 'IndentChar4']
  let g:indent_blankline_space_char_highlight_list = ['IndentSpaceChar1', 'IndentSpaceChar2', 'IndentSpaceChar3', 'IndentSpaceChar4']
  let g:indent_blankline_show_trailing_blankline_indent=v:false
]])

require 'colorizer'.setup {
  '*';
  css = { rgb_fn = true; };
  html = { names = true; };
}

require'shade'.setup({
  overlay_opacity = 40,
  opacity_step = 1,
})

require'lsp_signature'.on_attach()

require("neogit").setup {
  disable_signs = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
};


local dap = require('dap')
vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='TSDanger', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='TSNote', numhl=''})
vim.g.dap_virtual_text = 'all frames';

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/Users/lucas/.vscode/extensions/felixfbecker.php-debug-1.16.1/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 8000
  }
}

