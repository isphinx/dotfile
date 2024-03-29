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

-- vim.cmd('colorscheme github_light')
vim.cmd("colorscheme tokyonight")
vim.cmd('syntax enable')
vim.cmd('set nofoldenable')
vim.cmd('set termguicolors')
vim.cmd('set wrap')
vim.cmd('autocmd Filetype javascriptreact setlocal ts=2 sw=2 sts=0 expandtab')
vim.cmd('autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab')
vim.cmd('autocmd Filetype typescript setlocal ts=2 sw=2 sts=0 expandtab')
vim.cmd('autocmd Filetype typescriptreact setlocal ts=2 sw=2 sts=0 expandtab')
vim.cmd('autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab')

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim", "zsh" },
})

require('nvim-treesitter.configs').setup {
  autopairs = {enable = true},
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
}

require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAdd'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChange', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDelete', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  diff_opts = {
    internal=true,
  },
  word_diff = true,
  numhl = true,
  linehl = false,
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  keymaps = {},
})

-- require("github-theme").setup({ theme_style = "light", })

-- let g:indent_blankline_char = '▏'
vim.cmd([[
  let g:indent_blankline_char = '▏'
  let g:indent_blankline_show_end_of_line = v:true
  let g:indent_blankline_use_treesitter = v:true
  let g:indent_blankline_filetype_exclude = ['help','dashboard','dashpreview','NvimTree','coc-explorer','startify','vista','sagahover']

  hi IndentChar1 guifg=#bae1ff gui=nocombine
  hi IndentChar2 guifg=#efcfaa gui=nocombine
  hi IndentChar2 guifg=#b071e3 gui=nocombine
  hi IndentChar4 guifg=#ef83aa gui=nocombine
  hi IndentChar5 guifg=#efefaa gui=nocombine
  hi IndentChar6 guifg=#aaefb9 gui=nocombine
  hi IndentChar7 guifg=#ee82ee gui=nocombine

  let g:indent_blankline_char_highlight_list = ['IndentChar1', 'IndentChar2', 'IndentChar3', 'IndentChar4', 'IndentChar5', 'IndentChar6', 'IndentChar7']
  let g:indent_blankline_show_trailing_blankline_indent=v:false
]])

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentChar1",
        "IndentChar2",
        "IndentChar3",
        "IndentChar4",
        "IndentChar5",
        "IndentChar6",
        "IndentChar7",
    },
}

-- vim.g.indent_blankline_show_current_context = true
-- vim.g.indent_blankline_context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'}
vim.g.user_emmet_leader_key=','

require 'colorizer'.setup {
  '*';
  css = { rgb_fn = true; };
  html = { names = true; };
}

require'shade'.setup({
  overlay_opacity = 40,
  opacity_step = 1,
})

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

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/Users/lucas/.vscode/extensions/felixfbecker.php-debug-1.21.0/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 8000
  }
}

-- require'lualine'.setup{ options = { theme  = 'github' }}
require'lualine'.setup{ options = { theme  = 'tokyonight' }}

require('Comment').setup()

require("todo-comments").setup()

require("format").setup {
    typescript = {
        {cmd = {"deno fmt --options-single-quote"}}
    },
    javascript = {
        {cmd = {"deno fmt --options-single-quote"}}
    },
    json = {
        {cmd = {"deno fmt"}}
    }
}
