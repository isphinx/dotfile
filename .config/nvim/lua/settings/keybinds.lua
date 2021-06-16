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

---[[-----------------]]---
--    LSP Keybindings    --
---]]-----------------[[---

-- https://github.com/hrsh7th/nvim-compe#mappings
Map('i', '<expr> <C-Space>', Fn['compe#complete'](), opts)
Map('i', '<expr> <CR>', Fn['compe#confirm']('<CR>'), opts)
Map('i', '<expr> <C-e>', Fn['compe#close']('<C-e>'), opts)
Map('i', '<expr> <C-f>', Fn['compe#scroll']({ delta = '+4' }), opts)
Map('i', '<expr> <C-d>', Fn['compe#scroll']({ delta = '-4' }), opts)
Map('n', 'gR', ':Gitsigns reset_hunk<CR>', opts)
Map('n', 'gh', ':Gitsigns preview_hunk<CR>', opts)
Map('n', 'gcc', '<Plug>kommentary_line_increase', opts)
Map('v', 'gc', '<Plug>kommentary_visual_default', opts)
Map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', opts) -- gd: jump to definitionA
Map('n', 'gr', ':Lspsaga lsp_finder<CR>', opts) -- gr: go to reference
Map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', opts) -- gi: buf implementation
Map('n', 'gs', ':lua require("lspsaga.floaterm").open_float_terminal("gitui")<CR>', opts) -- gi: buf implementation
Map('n', 'ca', ':Lspsaga code_action<CR>', opts) -- ca: code actions
Map('n', '<C-q>', ':Lspsaga close_floaterm<CR>', opts) -- gi: buf implementation
Map('n', 'K', ':Lspsaga hover_doc<CR>', opts) -- K: hover doc
Map('n', '<C-p>', ':Lspsaga diagnostic_jump_prev<CR>', opts) -- Control+p: Jump to previous diagnostic
Map('n', '<C-n>', ':Lspsaga diagnostic_jump_next<CR>', opts) -- Control+n: Jump to next diagnostic
Map('n', '<C-f>', ':lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts) -- Control+f: Scroll down documents
Map('n', '<C-b>', "lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>") -- Control+b: Scroll up documents
Cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

Map('n', '<Tab>', ':bp<CR>', opts)   -- TAB to cycle buffers too, why not?
Map('n', '<esc>', ':noh<CR>', opts)     -- ESC to turn off search highlighting

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
      name = '+buffer',
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
      name = '+file',
      --c = { ':e $MYVIMRC<CR>', 'Edit Neovim configuration' },
      f = { ':Telescope file_browser theme=get_ivy<CR>', 'Find files' },
      y = { ':file<CR>', 'file name' },
      p = { ':Telescope git_files theme=get_ivy<CR>', 'Find files' },
      d = { ':Telescope grep_string theme=get_ivy<CR>', 'Find word' },
      w = { ':Telescope live_grep theme=get_ivy<CR>', 'Find word' },
      r = { ':Telescope oldfiles theme=get_ivy<CR>', 'Recently opened files' },
      s = { ':w<CR>', 'Save file' },
    },
  },
})

-- Toggler
wk.register({
  ['<leader>'] = {
    t = {
      name = '+toggle',
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
      name = '+git',
      r = { ':Gitsigns reset_hunk<CR>', 'Reset hunk' },
      h = { ':Gitsigns preview_hunk<CR>', 'Preview hunk' },
    },
  },
})

