local exec = vim.api.nvim_command
local fn, cmd = vim.fn, vim.cmd

local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  exec("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  exec "packadd packer.nvim"
end

cmd "packadd packer.nvim"

--cmd "au BufWritePost packages.lua PackerCompile"

return require('packer').startup(function()
	-- Plugins manager, remove the branch field when that branch is merged
	-- in the main branch.
	use({ 'wbthomason/packer.nvim', run = ':PackerSync' })

	-- Auxiliar functions for using Lua in Neovim
	use('svermeulen/vimpeccable')

	-- Tree-Sitter
	use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })

	-- Colorschemes
	use({ 'GustavoPrietoP/doom-themes.nvim' })
	-- use({ 'glepnir/zephyr-nvim' })
	-- use({ 'folke/tokyonight.nvim' })
  use({'projekt0n/github-nvim-theme'})
	use({ 'kyazdani42/nvim-web-devicons' })

	-- File tree
	-- use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } })

	-- Statusline
	use({ 'glepnir/galaxyline.nvim' })

	-- Viewer & finder for LSP symbols and tags
	use({ 'simrat39/symbols-outline.nvim' })

	-- Minimap
	-- Depends on wfxr/code-minimap to work!
	use({ 'wfxr/minimap.vim' })

	-- Keybindings menu like Emacs's guide-key
	-- cannot be disabled
	use({ 'folke/which-key.nvim' })

	-- Distraction free environment
	--local disabled_zen = Has_value(Doom.disabled_plugins, 'zen')
	--use({ 'kdav5758/TrueZen.nvim', disable = disabled_zen })

	-----[[--------------]]-----
	---     Fuzzy Search     ---
	-----]]--------------[[-----
	use({
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/popup.nvim' }, { 'nvim-lua/plenary.nvim' } },
	})

	-----[[-------------]]-----
	---     GIT RELATED     ---
	-----]]-------------[[-----
	use({ 'lewis6991/gitsigns.nvim' })
  use({ 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' })

	-- Built-in LSP Config
	use({ 'neovim/nvim-lspconfig' })
	-- Completion plugin
	-- can be disabled to use your own completion plugin
	use({
		'hrsh7th/nvim-compe',
		requires = {
			{ 'ray-x/lsp_signature.nvim' },
			{ 'onsails/lspkind-nvim' },
			{ 'norcalli/snippets.nvim' },
		},
	})

	-- install lsp saga
	use({ 'glepnir/lspsaga.nvim' })

	-- provides the missing `:LspInstall` for `nvim-lspconfig`.
	use({ 'kabouzeid/nvim-lspinstall' })

	-- File formatting
	-- can be disabled to use your own file formatter
	use({ 'lukas-reineke/format.nvim' })

	-- Autopairs
  use({ 'windwp/nvim-autopairs' })
	-- can be disabled to use your own autopairs

	-- Indent Lines
	use({ 'lukas-reineke/indent-blankline.nvim' })

	-- Comments
	use({ 'b3nj5m1n/kommentary' })

	use({ 'tpope/vim-surround' })

	---     Web Related     ---
	use({ 'norcalli/nvim-colorizer.lua' })

	-- HTTP Client support
	-- Depends on bayne/dot-http to work!
	-- use({ 'bayne/vim-dot-http' })

	-- Emmet plugin
	use({ 'mattn/emmet-vim' })

	use({ 'oberblastmeister/rooter.nvim' })

  use { "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({ })
    end
  }

	use({ 'p00f/nvim-ts-rainbow' })

	use({ 'sunjon/shade.nvim' })

  use({'mfussenegger/nvim-dap'})
  use({'theHamsta/nvim-dap-virtual-text'})
  use({'nvim-telescope/telescope-dap.nvim'})
  use({'nvim-telescope/telescope-fzy-native.nvim'})
  use({'nvim-telescope/telescope-fzf-writer.nvim'})
end)

