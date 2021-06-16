-- LSP Configuration
-- taken from https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
Api, Cmd, Fn = vim.api, vim.cmd, vim.fn
local nvim_lsp = require('lspconfig')
-- Snippets support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Lsp Symbols
Fn.sign_define(
    "LspDiagnosticsSignError",
    {texthl = "LspDiagnosticsSignError", text = '', numhl = "LspDiagnosticsSignError"}
)
Fn.sign_define(
    "LspDiagnosticsSignWarning",
    {texthl = "LspDiagnosticsSignWarning", text = '', numhl = "LspDiagnosticsSignWarning"}
)
Fn.sign_define(
    "LspDiagnosticsSignHint",
    {texthl = "LspDiagnosticsSignHint", text = '', numhl = "LspDiagnosticsSignHint"}
)
Fn.sign_define(
    "LspDiagnosticsSignInformation",
    {texthl = "LspDiagnosticsSignInformation", text = '', numhl = "LspDiagnosticsSignInformation"}
)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = { prefix = ' ', },
  }
)

-- Signature help
require('lsp_signature').on_attach()

-- Vscode-like pictograms on completion
require('lspkind').init({
  with_text = true,
  symbol_map = {
    Text = '',
    Method = 'ƒ',
    Function = '',
    Constructor = '',
    Variable = '',
    Class = '',
    Interface = 'ﰮ',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '了',
    Keyword = '',
    Snippet = '﬌',
    Color = '',
    File = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
  },
})

local on_attach = function(client, bufnr)
local function buf_set_option(...)
    Api.nvim_buf_set_option(bufnr, ...)
end

buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
-- Mappings.
local opts = { silent = true }
Map('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
Map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
Map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
Map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
Map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
Map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
Map('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
Map('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
Map('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
Map('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
Map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
Map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
Map('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
Map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
Map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
Map('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

-- Set some keybinds conditional on server capabilities
if client.resolved_capabilities.document_formatting then
    Map('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
elseif client.resolved_capabilities.document_range_formatting then
    Map('n', '<space>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
end
-- Set autocommands conditional on server_capabilities
if client.resolved_capabilities.document_highlight then
    Api.nvim_exec( [[
    hi LspReferenceRead ctermbg=237 guibg=LightYellow
    hi LspReferenceText ctermbg=237 guibg=LightYellow
    hi LspReferenceWrite ctermbg=237 guibg=LightYellow
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
  ]],
    false
    )
end
end

--[[-----------------]]
--
--      LSP Setup      --
--]]-----------------[[--
-- https://github.com/kabouzeid/nvim-lspinstall#advanced-configuration-recommended
local function setup_servers()
  -- Provide the missing :LspInstall
  require('lspinstall').setup()
  local servers = require('lspinstall').installed_servers()
  for _, server in pairs(servers) do
    nvim_lsp[server].setup({})
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require('lspinstall').post_install_hook = function()
  setup_servers() -- reload installed servers
  Cmd('bufdo e') -- this triggers the FileType autocmd that starts the server
end

--- nvim-compe configuration
require('compe').setup({
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = 'enable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    snippets_nvim = true,
    treesitter = true,
  },

})
local t = function(str)
  return Api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = Fn.col('.') - 1
    if col == 0 or Fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if Fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return Fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if Fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

Map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
Map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
Map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
Map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'javascript' },
  highlight = { enable = true },
  indent = { enable = true },
})
