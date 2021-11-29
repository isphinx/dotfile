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
-- _G.tab_complete = function()
--   if Fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--   end
-- end
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
Map("s", "<!-- <S-Tab> -->", "v:lua.s_tab_complete()", {expr = true})

require('nvim-treesitter.configs').setup({
  ensure_installed = { 'javascript' },
  highlight = { enable = true },
  indent = { enable = true },
})

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = {
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        })
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'treesitter' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

local lspkind = require('lspkind')
cmp.setup {
  formatting = {
    format = lspkind.cmp_format({with_text = false, menu = ({
      buffer = "[Buf]",
      nvim_lsp = "[LSP]",
      luasnip = "[LuaSnip]",
      nvim_lua = "[Lua]",
      latex_symbols = "[Latex]",
    })}),
  },
}

require "lsp_signature".setup()
