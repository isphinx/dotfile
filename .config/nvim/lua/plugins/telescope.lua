-- https://github.com/nvim-telescope/telescope.nvim#telescope-defaults
-- Required to close with ESC in insert mode
local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
  defaults = {
    find_command = {'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},
    mappings = {
      i = {
        ["jl"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<C-c>"] = actions.delete_buffer,
        ["<CR>"] = actions.select_default + actions.center
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.delete_buffer,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      }
    }
  },
  extensions = {
    fzf_writer = {
      minimum_grep_characters = 4,
      minimum_files_characters = 4,
      use_highlighter = true,
    }
  }
})

telescope.load_extension('dap')
telescope.load_extension('projects')
-- telescope.load_extension('fzy_native')
