local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

-- local luasnip = require('luasnip')

lazy.setup({
	root = vim.fn.stdpath("data") .. "/lazy",
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- LSP Stuff
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"glepnir/lspsaga.nvim",
			"RRethy/vim-illuminate",
			-- Completions
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "dcampos/nvim-snippy",
			"doxnit/cmp-luasnip-choice",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
            "junegunn/vim-easy-align",
            "sbdchd/neoformat",
			"lukas-reineke/cmp-under-comparator",
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-vsnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			-- "hrsh7th/cmp-copilot",
		},
		config = function()
			-- Lsp Configs
			require("plugins.configs.lsp")
			-- Completions
			require("plugins.configs.cmp")
		end,
	},

    -- MY OWN CONFIGS
    {
       "andrewferrier/wrapping.nvim",
        config = function()
            require("wrapping").setup()
        end
    },
    {
       "mg979/vim-visual-multi",
       config = function()
           -- require("plugins.configs.vim_visual_multi")
       end,
    },
    {
      "folke/zen-mode.nvim",
      opts = {}
    },
    {
       "lervag/vimtex",
       config = function()
           -- require("plugins.configs.vimtex")
       end,
    },
    {
       "tpope/vim-surround",
       config = function()
           -- require("plugins.configs.surround")
       end,
    },
    -- colorschemes:
    { "nyoom-engineering/oxocarbon.nvim" }, 
    { 'kepano/flexoki-neovim', name = 'flexoki' },
    { 'jacoborus/tender.vim' },
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    { 'mcchrish/zenbones.nvim' },
    { 'rktjmp/lush.nvim' },
    {
    'L3MON4D3/LuaSnip',
    dependencies = {
        "friendly-snippets",
        "nvim-cmp"
    },
    config = function()
        require("plugins.configs.luasnip")
    end,
    },
    -- {
    --     "L3MON4D3/LuaSnip",
    --     -- follow latest release.
    --     version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    --     build = "make install_jsregexp",
    --     config = function()
    --         require("luasnip.loaders.from_lua").lazy_load()
    --         -- require("luasnip").add_snippets(tex, snippets)
    --         -- require("luasnip.loaders.from_snipmate").lazy_load()
    --     end,
    -- },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.configs.colorschemes")
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.configs.ui.bufferline")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.configs.ui.lualine")
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"ravenxrz/DAPInstall.nvim",
		},
		config = function()
			require("plugins.configs.ui.dap")
		end,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
		},
		opts = require("plugins.configs.lsp.bbq"),
	},
    {
        "nvim-tree/nvim-tree.lua",
        config = function ()
			require("plugins.configs.ui.nvim-tree")
        end,
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NeoTree" },
		},
    },
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	event = "BufEnter",
	-- 	config = function()
	-- 		require("plugins.configs.ui.indent_blankline")
	-- 	end,
	-- },
	{
		"alvan/vim-closetag",
		config = function()
			vim.g.closetag_filenames = "*.html,*.xhtml,*.phtml"
			vim.g.closetag_xhtml_filenames = "*.xhtml,*.jsx"
		end,
	},
	{ "windwp/nvim-autopairs", config = true, event = "InsertEnter" },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("plugins.configs.telescope")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
    {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require"telescope".load_extension("frecency")
      end,
      dependencies = {"kkharji/sqlite.lua"}
    },
	{ "ahmedkhalf/project.nvim" },
	{ "numToStr/Comment.nvim", config = true, event = "BufEnter" },
	{ "lewis6991/gitsigns.nvim", config = true, event = "BufEnter" },
	{
		"kdheepak/lazygit.nvim",
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "NeoTree" },
		},
	},

	{
		"karb94/neoscroll.nvim",
		event = "BufEnter",
		config = function()
			require("neoscroll").setup({})
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("plugins.configs.ui.toggleterm")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("plugins.configs.ui.scrollbar")
		end,
	},
	{
		"goolord/alpha-nvim",
		config = function()
			require("plugins.configs.ui.alpha")
		end,
	},
	{
		"lewis6991/impatient.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugins.configs.treesitter")
		end,
	},
	{ "windwp/nvim-ts-autotag" },
	{
		"iamcco/markdown-preview.nvim",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-- { "github/copilot.vim" },
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"max397574/better-escape.nvim",
		opts = {
			mapping = { "jk", "jj" },
			timeout = vim.o.timeoutlen,
			clear_empty_lines = false,
			keys = "<Esc>",
		},
		event = { "CmdlineEnter", "InsertEnter", "CursorHold", "CursorMoved" },
	},
	-- {
	-- 	"doums/monark.nvim",
	-- 	opts = {
	-- 		clear_on_normal = true,
	-- 		sticky = true,
	-- 		offset = 2,
	-- 		timeout = 300,
	-- 		i_idle_to = 1000,
	-- 		modes = {
	-- 			normal = { " ", "MonarkNormal" },
	-- 			visual = { " ", "MonarkVisual" },
	-- 			visual_l = { " ", "MonarkVisualLine" },
	-- 			visual_b = { " ", "MonarkVisualBlock" },
	-- 			select = { " ", "MonarkSelect" },
	-- 			insert = { " ", "MonarkInsert" },
	-- 			replace = { " ", "MonarkReplace" },
	-- 			terminal = { " ", "MonarkTerminal" },
	-- 		},
	-- 		hl_mode = "combine",
	-- 		ignore = { "c" },
	-- 	},
	-- 	event = "InsertEnter",
	-- },
	{
		"folke/twilight.nvim",
		config = function()
			require("plugins.configs.ui.twilight")
			-- vim.cmd("Twilight")
		end,
	},
	{
		"kevinhwang91/rnvimr",
		init = function()
			require("plugins.configs.ranger")
		end,
		lazy = false,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
        config = function ()
          require('plugins.configs.ui.noice')
        end
	},
    { "anuvyklack/windows.nvim",
       dependencies = {
          "anuvyklack/middleclass",
          "anuvyklack/animation.nvim"
       },
       config = function()
          vim.o.winwidth = 10
          vim.o.winminwidth = 10
          vim.o.equalalways = false
          require('windows').setup()
       end
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      keys = {
        {
          "s",
          mode = { "n", "x", "o" },
          function()
            -- default options: exact mode, multi window, all directions, with a backdrop
            require("flash").jump()
          end,
        },
        {
          "S",
          mode = { "o", "x" },
          function()
            require("flash").treesitter()
          end,
        },
      },
    },
    {
        "ChristianChiarulli/onedark.nvim"
    },
    {
        'marko-cerovac/material.nvim'
    }
})
