{
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;

    # Theme configuration
    colorschemes.oxocarbon = {
      enable = true;
    };

    # Extra packages
    extraPackages = with pkgs; [
      python312Packages.jupytext
      python312Packages.jupyter
      python312Packages.ipython
      python312Packages.ipykernel
      python312Packages.pynvim
      python312Packages.jupyter-client
      python312Packages.cairosvg # For image rendering
      python312Packages.pillow # For image rendering
      python312Packages.plotly # Optional: for plotly support
      imagemagick # For image rendering
      carbon-now-cli
      alejandra
      vimPlugins.molten-nvim
      prettierd
      ruff
    ];

    # Global options
    globals.mapleader = " ";

    opts = {
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      relativenumber = true;
      number = true;
      clipboard = "unnamedplus"; # useSystemClipboard
      signcolumn = "yes";
      updatetime = 300;
    };

    # Plugins configuration
    plugins = {
      # Terminal
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<c-\\>]]";
          direction = "float";
        };
      };

      # Status line
      lualine = {
        enable = true;
      };

      # Telescope
      telescope = {
        enable = true;
      };

      # Web devicons (explicitly enabled to avoid deprecation warning)
      web-devicons = {
        enable = true;
      };

      # Autocompletion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
          ];
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
          };
          window = {
            completion = {
              border = "rounded";
            };
            documentation = {
              border = "rounded";
            };
          };
        };
      };

      cmp-nvim-lsp = {
        enable = true;
      };

      cmp-buffer = {
        enable = true;
      };

      cmp-path = {
        enable = true;
      };

      # Spellcheck
      cmp-spell = {
        enable = true;
      };

      # Motion
      leap = {
        enable = true;
      };

      # Mini plugins
      mini = {
        enable = true;
        modules = {
          surround = {};
          pairs = {};
          move = {};
          comment = {};
          icons = {};
        };
      };

      # Snippets
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          exit_roots = false;
          keep_roots = true;
          link_roots = true;
          update_events = [
            "TextChanged"
            "TextChangedI"
          ];
          store_selection_keys = "<Tab>";
        };
        fromLua = [
          {
            paths = "~/dotfiles/homes/mambaLaptop/lua_snip_snippets/";
          }
        ];
      };

      # Which key
      which-key = {
        enable = true;
      };

      # Visual enhancements
      indent-blankline = {
        enable = true;
      };

      # Treesitter
      treesitter = {
        enable = true;
        settings = {
          auto_install = false;
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Auto-tag for HTML
      ts-autotag = {
        enable = true;
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true; # Nix
          julials.enable = true; # Julia
          julials.package = null;
          pyright.enable = true; # Python
          ts_ls.enable = true; # TypeScript
          tailwindcss.enable = true; # Tailwind
          svelte.enable = true; # Svelte
          html.enable = true; # HTML
        };
      };

      # A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
      trouble = {
        enable = true;
        settings = {
          auto_open = false;
          auto_close = true;
          use_diagnostic_signs = true;
        };
      };

      # Formatting
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            python = ["ruff"];
            typescript = ["prettier"];
            javascript = ["prettier"];
            svelte = ["prettier"];
            html = ["prettier"];
            nix = ["alejandra"];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
        };
      };

      # Markdown
      render-markdown = {
        enable = true;
      };

      # Additional plugins
      lastplace = {
        enable = true;
      };

      vimtex = {
        enable = true;
      };

      harpoon = {
        enable = true;
      };

      # Molten plugin configuration - FIXED with proper closing brace
      molten = {
        enable = true;
        settings = {
          auto_image_popup = false;
          auto_init_behavior = "init";
          auto_open_html_in_browser = false;
          auto_open_output = true;
          cover_empty_lines = false;
          copy_output = false;
          enter_output_behavior = "open_then_enter";
          image_provider = "none";
          output_crop_border = true;
          output_virt_lines = false;
          # Enhanced border for better visibility
          output_win_border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
          output_win_hide_on_leave = false; # Keep output visible
          # Significantly increased output window size
          output_win_max_height = 30; # Increased from 15
          output_win_max_width = 120; # Increased from 80
          output_win_style = "minimal";
          save_path.__raw = "vim.fn.stdpath('data')..'/molten'";
          tick_rate = 500;
          use_border_highlights = true; # Enable border highlights
          limit_output_chars = 50000; # Increased from 10000
          wrap_output = true; # Enable text wrapping
          # Additional display options
          output_show_more = true;
          output_win_cover_gutter = true;
        };
      };

      highlight-colors = {
        enable = true;
      };
    }; # <- This was the missing closing brace for the plugins section

    # Extra plugin configurations
    extraPlugins = with pkgs.vimPlugins; [
      wrapping-nvim
      img-clip-nvim
      NotebookNavigator-nvim
      jupytext-nvim
      nvim-ts-context-commentstring
    ];

    extraConfigLua = ''
      -- Wrapping configuration
      require('wrapping').setup {}

      -- Image clip configuration
      require('img-clip').setup {}

      -- Notebook navigator configuration
      require('notebook-navigator').setup({
          activate_hydra = false,
          repl_provider = 'molten',
          syntax_highlight = false,
          cell_markers = {
              "# %%",
              "#%%",
              "# <codecell>",
              "## %%",
          },
          -- highlight = {
          --     enable = true,
          --     mode = "all", -- or "code_cells"
          -- }
      })

      -- Jupytext configuration
      require('jupytext').setup {}

      -- Context commentstring configuration
      require('ts_context_commentstring').setup {}

      -- Enhanced LSP diagnostics configuration for inline errors
      vim.diagnostic.config({
          virtual_text = {
              enabled = true,
              source = "if_many",
              prefix = "●",
          },
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
              focusable = false,
              style = "minimal",
              border = "rounded",
              source = "always",
              header = "",
              prefix = "",
          },
      })

      -- Customize diagnostic signs
      local signs = {
          Error = "󰅚 ",
          Warn = "󰀪 ",
          Hint = "󰌶 ",
          Info = " "
      }
      for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- Spellcheck ignored filetypes
      vim.api.nvim_create_autocmd("FileType", {
          pattern = {"toggleterm", "python", "julia", "nix", "svelte", "typescript"},
          callback = function()
              vim.opt_local.spell = false
          end,
      })
    '';

    # Keymaps
    keymaps = [
      # Semicolon to colon
      {
        key = ";";
        action = ":";
        mode = "n";
        options.silent = true;
      }

      # LuaSnip expand
      {
        key = "<C-k>";
        action = "<cmd>lua require('luasnip').expand()<CR>";
        mode = "i";
        options.silent = true;
      }

      # Visual mode indenting
      {
        key = "<";
        action = "<gv";
        mode = "v";
        options.silent = true;
      }

      {
        key = ">";
        action = ">gv";
        mode = "v";
        options.silent = true;
      }

      # LuaSnip navigation
      {
        key = "<C-L>";
        action = "<cmd>lua require('luasnip').jump(1)<CR>";
        mode = "i";
        options.silent = true;
      }

      {
        key = "<C-J>";
        action = "<cmd>lua require('luasnip').jump(-1)<CR>";
        mode = "i";
        options.silent = true;
      }

      # File explorer
      {
        key = "<leader>pv";
        action = "<cmd>Ex<CR>";
        mode = "n";
        options.silent = true;
      }

      # Better j/k movement
      {
        key = "j";
        action = "gj";
        mode = "n";
        options.silent = true;
      }

      {
        key = "k";
        action = "gk";
        mode = "n";
        options.silent = true;
      }

      # Terminal mode escape
      {
        key = "<Esc>";
        action = "<c-\\><c-n>";
        mode = "t";
        options.silent = true;
      }

      # Terminal toggle from terminal mode
      {
        key = "<c-\\>";
        action = "<c-\\><c-n><cmd>ToggleTerm<CR>";
        mode = "t";
        options.silent = true;
      }

      # Notebook navigator
      {
        key = "<leader>X";
        action = "<cmd>lua require('notebook-navigator').run_cell()<CR>";
        mode = "n";
        options.silent = true;
      }

      {
        key = "<leader>x";
        action = "<cmd>lua require('notebook-navigator').run_and_move()<CR>";
        mode = "n";
        options.silent = true;
      }

      {
        key = "]h";
        action = "<cmd>lua require('notebook-navigator').move_cell('d')<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Move to next cell";
        };
      }

      {
        key = "[h";
        action = "<cmd>lua require('notebook-navigator').move_cell('u')<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Move to previous cell";
        };
      }

      # Create new cell above/below
      {
        key = "<leader>ca";
        action = "<cmd>lua require('notebook-navigator').add_cell('above')<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Add cell above";
        };
      }

      {
        key = "<leader>cb";
        action = "<cmd>lua require('notebook-navigator').add_cell('below')<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Add cell below";
        };
      }

      # Delete current cell
      {
        key = "<leader>cd";
        action = "<cmd>lua require('notebook-navigator').delete_cell()<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Delete current cell";
        };
      }

      # Molten keybinds
      {
        key = "<leader>mi";
        action = ":MoltenInit<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Initialize the plugin";
        };
      }

      {
        key = "<leader>e";
        action = ":MoltenEvaluateOperator<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "run operator selection";
        };
      }

      {
        key = "<leader>rl";
        action = ":MoltenEvaluateLine<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "evaluate line";
        };
      }

      {
        key = "<leader>rr";
        action = ":MoltenReevaluateCell<CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "re-evaluate cell";
        };
      }

      {
        key = "<leader>r";
        action = ":<C-u>MoltenEvaluateVisual<CR>gv";
        mode = "v";
        options = {
          silent = true;
          desc = "evaluate visual selection";
        };
      }

      # Telescope search files
      {
        action = ":Telescope find_files<CR>";
        key = "<leader>ff";
        options = {
          silent = true;
          noremap = true;
          desc = "Search files";
        };
      }
    ];
  };
}
