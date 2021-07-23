Api, Cmd, Fn = vim.api, vim.cmd, vim.fn
Keymap, Execute, G = Api.nvim_set_keymap, Api.nvim_command, vim.g
function Map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    Keymap(mode, lhs, rhs, options)
end

--     keybindings --
local wk = require('which-key')

-- and call leader mapper
Map('n', '<Space>', '<Nop>')
Api.nvim_set_var('mapleader', ' ')

-- Additional options for mappings
local opts = { silent = true }

--    LSP Keybindings    --
Map('i', '<expr> <C-Space>', Fn['compe#complete'](), opts)
Map('i', '<expr> <CR>', Fn['compe#confirm']('<CR>'), opts)
Map('i', '<expr> <C-e>', Fn['compe#close']('<C-e>'), opts)
Map('i', '<expr> <C-f>', Fn['compe#scroll']({ delta = '+4' }), opts)
Map('i', '<expr> <C-d>', Fn['compe#scroll']({ delta = '-4' }), opts)
Map('n', 'gh', ':Gitsigns preview_hunk<CR>', opts)
Map('n', 'gcc', '<Plug>kommentary_line_increase', opts)
Map('v', 'gc', '<Plug>kommentary_visual_default', opts)
Map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts) -- gd: jump to definitionA
Map('n', 'gr', ':Lspsaga lsp_finder<CR>', opts) -- gr: go to reference
Map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts) -- gi: buf implementation
Map('n', 'ca', ':Lspsaga code_action<CR>', opts) -- ca: code actions
Map('n', 'jl', ':Lspsaga close_floaterm<CR>', opts) -- gi: buf implementation
Map('n', 'K', ':Lspsaga hover_doc<CR>', opts) -- K: hover doc
Map('n', '<C-p>', ':Lspsaga diagnostic_jump_prev<CR>', opts) -- Control+p: Jump to previous diagnostic
Map('n', '<C-n>', ':Lspsaga diagnostic_jump_next<CR>', opts) -- Control+n: Jump to next diagnostic
Map('n', '<C-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts) -- Control+f: Scroll down documents
Map('n', '<C-b>', "lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>") -- Control+b: Scroll up documents
Cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

Map('n', '<C-k>', ':lua require("dap").step_out()<CR>', opts)
Map('n', '<C-l>', ':lua require("dap").step_into()<CR>', opts)
Map('n', '<C-j>', ':lua require("dap").step_over()<CR>', opts)

Map('n', '<Tab>', ':bp<CR>', opts)
Map('n', '<C-Tab>', ':bn<CR>', opts)
Map('n', '<esc>', ':noh<CR>', opts)

---[[-----------------]]---
--     Escape Remaps     --
---]]-----------------[[---
Map('i', 'jl', '<ESC>', opts)
Cmd('tnoremap jl <C-\\><C-n>')  -- get out of terminal insert mode into normal mode with Esc

Map('n', '<c-z>', '<Nop>')      -- Disable accidentally pressing ctrl-z and suspending
Map('n', 'Q', '<Nop>')          -- Disable ex mode
Map('n', 'q', '<Nop>')          -- Disable recording

---[[-----------------]]---
--      Leader keys      --
---]]-----------------[[---
-- Buffers
wk.register({
  ['<leader>'] = {
    b = {
      name = ' buffer',
      d = { ':bd<CR>', 'Close buffer' },
--      f = { ':FormatWrite<CR>', 'Format buffer' },
      f = { ':!deno fmt %<CR>', 'Format buffer' },
      b = { ':Telescope buffers theme=get_ivy<CR>', 'Select buffer' },
      s = { ':Telescope current_buffer_fuzzy_find theme=get_ivy<CR>', 'Search current buffer' },
    },
  },
})

-- File
wk.register({
  ['<leader>'] = {
    f = {
      name = ' file',
      y = { ':file<CR>', 'file name' },
      f = { ':Telescope file_browser theme=get_ivy cwd=%:p:h<CR>', 'Find files' },
      p = { ':Telescope git_files theme=get_ivy<CR>', 'Find files' },
      d = { ':Telescope grep_string theme=get_ivy<CR>', 'Find word' },
      w = { ':lua require("telescope").extensions.fzf_writer.grep(require("telescope.themes").get_ivy({}))<CR>', 'Find word' },
      r = { ':Telescope oldfiles theme=get_ivy<CR>', 'Recently opened files' },
      s = { ':w<CR>', 'Save file' },
    },
  },
})

-- Toggler
wk.register({
  ['<leader>'] = {
    t = {
      name = ' toggle',
      c = { ':Telescope colorscheme<CR>', 'Change colorscheme' },
      m = { ':MinimapToggle<CR>', 'Toggle Minimap' },
      t = { ':Lspsaga open_floaterm<CR>', 'Toggle terminal' },
      a = { '<Plug>ColorizeToggle', 'Toggle colorize' },
    },
  },
})

-- If Git is enabled
wk.register({
  ['<leader>'] = {
    g = {
      name = ' git',
      r = { ':Gitsigns reset_hunk<CR>', 'Reset Hunk' },
      h = { ':Gitsigns preview_hunk<CR>', 'Preview Hunk' },
      b = { ':Gitsigns blame_line<CR>', 'Blame Line' },
      s = { ':Neogit kind=vsplit<CR>', 'Neogit' },
    },
  },
})

-- Debug
wk.register({
  ['<leader>'] = {
    d = {
      name = ' debug',
      s = {':lua require"dap".stop()<CR>', 'Stop Debug'},
      l = {':lua require"dap".continue()<CR>', 'Start Debug'},
      k = {':lua require"dap".disconnect()<CR>', 'Disconnect Debug'},
      b = {':lua require"dap".toggle_breakpoint()<CR>', 'Breakpoint Toggle'},
      d = {':Telescope dap commands<CR>', 'Commands'},
      c = {':Telescope dap configurations<CR>', 'Configurations'},
      p = {':Telescope dap list_breakpoints<CR>', 'List Breakpoint'},
      -- v = {':Telescope dap variables<CR>', 'Variables'},
      f = {':Telescope dap frames<CR>', 'Stack List'},

      u = {':lua require"dap".up()<CR>', 'Stack Up'},
      n = {':lua require"dap".down()<CR>', 'Stack Down'},
      r = {':lua require"dap".repl.open({}, "vsplit")<CR>', 'Open REPL'},
      h = {':lua require"dap.ui.variables".hover()<CR>', 'Widgets'},
      w = {':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>', ' Widget Float'},
    },
  },
})

