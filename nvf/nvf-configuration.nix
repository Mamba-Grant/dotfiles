{
  pkgs,
  lib,
  ...
}: {
  vim = {
    theme = {
      enable = true;
      name = "oxocarbon";
      style = "dark";
    };

    extraPackages = with pkgs; [python312Packages.jupytext carbon-now-cli];
    terminal.toggleterm.enable = true;
    terminal.toggleterm.mappings.open = "<c-\\>";
    terminal.toggleterm.setupOpts.direction = "float";
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    useSystemClipboard = true;
    spellcheck.enable = true;
    spellcheck.ignoredFiletypes = ["toggleterm" "python" "julia" "nix" "svelte" "typescript"];
    # comments.comment-nvim.enable = true;

    utility.motion.leap.enable = true;

    mini.surround.enable = true;
    mini.pairs.enable = true;
    mini.move.enable = true;
    mini.comment.enable = true;
    mini.icons.enable = true;

    snippets = {
      luasnip.enable = true;
      luasnip.setupOpts.enable_autosnippets = true;
      luasnip.loaders = "require('luasnip.loaders.from_lua').lazy_load({paths = '~/dotfiles/nvf/LuaSnipSnippets/'})";
      luasnip.setupOpts = {
        store_selection_keys = "<Tab>";
      };
    };

    options = {
      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      relativenumber = true;
    };

    binds = {
      whichKey.enable = true;
    };

    keymaps = [
      {
        key = ";";
        mode = "n";
        silent = true;
        action = ":";
      }

      {
        key = "<C-k>";
        mode = "i";
        silent = true;
        action = "<cmd>lua require('luasnip').expand()<Cr>";
      }

      {
        key = "<";
        mode = "v";
        silent = true;
        action = "<gv";
      }

      {
        key = ">";
        mode = "v";
        silent = true;
        action = ">gv";
      }

      {
        key = "<C-L>";
        mode = "i";
        silent = true;
        action = "<cmd>lua require('luasnip').jump(1)<Cr>";
      }

      {
        key = "<C-J>";
        mode = "i";
        silent = true;
        action = "<cmd>lua require('luasnip').jump(-1)<Cr>";
      }

      {
        key = "<leader>pv";
        mode = "n";
        silent = true;
        action = "<cmd>:Ex<CR>";
      }

      {
        key = "j";
        mode = "n";
        silent = true;
        action = "gj";
      }

      {
        key = "k";
        mode = "n";
        silent = true;
        action = "gk";
      }

      {
        key = "<Esc>";
        mode = "t";
        silent = true;
        action = "<c-\><c-n>";
      }

      {
        key = "<c-\\>";
        mode = "t";
        silent = true;
        action = "<c-\\><c-n><cmd>:ToggleTerm<CR>";
      }

      {
        key = "<leader>X";
        mode = "n";
        silent = true;
        action = "<cmd>lua require('notebook-navigator').run_cell()<cr>";
      }

      {
        key = "<leader>x";
        mode = "n";
        silent = true;
        action = "<cmd>lua require('notebook-navigator').run_and_move()<cr>";
      }
    ];

    lsp.formatOnSave = true;
    visuals.indent-blankline.enable = true;

    treesitter = {
      autotagHtml = true;
    };

    languages = {
      enableLSP = true;
      enableTreesitter = true;
      enableFormat = true;

      nix = {
        enable = true;
        lsp.enable = true;
      };

      julia = {
        lsp.package = null; # I disable this since I have julia installed on its own
        enable = true;
        lsp.enable = true;
      };

      python = {
        enable = true;
        format.enable = true;
        format.type = "ruff";
        lsp.server = "pyright";
      };

      markdown = {
        enable = true;
        extensions.render-markdown-nvim.enable = true;
      };

      ts = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
        extensions.ts-error-translator.enable = true;
      };

      tailwind = {
        enable = true;
        lsp.enable = true;
      };

      svelte = {
        enable = true;
        lsp.enable = true;
        format.enable = true;
      };

      html = {
        enable = true;
        treesitter.autotagHtml = true;
      };
    };

    # lazy.plugins."mini-hipatterns" = {
    #   package = "mini-hipatterns";
    #   setupOpts = ''
    #     local nn = require("notebook-navigator")
    #     require("mini.hipatterns").setup({
    #       highlighters = {
    #         cells = nn.minihipatterns_spec
    #       }
    #     })
    #   '';
    # };

    extraPlugins = with pkgs.vimPlugins; {
      nvim-lastplace = {
        package = nvim-lastplace;
        setup = "require('nvim-lastplace').setup {}";
      };

      vimtex = {
        package = vimtex;
      };

      wrapping = {
        package = wrapping-nvim;
        setup = "require('wrapping').setup {}";
      };

      imge-clip-nvim = {
        package = img-clip-nvim;
        setup = "require('img-clip').setup {}";
      };

      harpoon = {
        package = harpoon;
        setup = "require('harpoon').setup {}";
      };

      iron = {
        package = iron-nvim;
        setup = ''
          local iron = require("iron.core")
          local view = require("iron.view")
          local common = require("iron.fts.common")

          iron.setup {
            config = {
              scratch_repl = true,
              repl_definition = {
                sh = {
                  command = {"fish"}
                },
                python = {
                  command = { "ipython", "--no-autoindent" },  -- or { "ipython", "--no-autoindent" } or { "python3" }
                  format = common.bracketed_paste_python,
                  block_dividers = { "# %%", "#%%" },
                }
              },
              repl_filetype = function(bufnr, ft)
                return ft
              end,
              repl_open_cmd = "vertical botright 80 split"
            },
            highlight = { italic = true },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
          }

          vim.keymap.set('n', '<space>\\', '<cmd>IronRepl<cr>')
        '';
      };

      notebook-navigator = {
        package = NotebookNavigator-nvim;
        setup = "require('notebook-navigator').setup {}";
      };

      mini-comment = {
        package = mini-comment;
        setup = "require('mini.comment').setup {}";
      };

      jupytext = {
        package = jupytext-nvim;
        setup = "require('jupytext').setup {}";
      };

      nvim-highlight-colors = {
        package = nvim-highlight-colors;
        setup = "require('nvim-highlight-colors').setup {}";
      };

      # vim-svelte = {
      #     package = vim-svelte;
      #     setup = "require('vim-svelte').setup {}";
      # };

      nvim-ts-context-commentstring = {
        package = nvim-ts-context-commentstring;
        setup = "require('ts_context_commentstring').setup {}";
      };

      nvim-ts-autotag = {
        package = nvim-ts-autotag;
        setup = "require('nvim-ts-autotag').setup {}";
      };

      # vim-carbon-now-sh = {
      #     package = vim-carbon-now-sh;
      #     setup = "require('carbon-now').setup {}";
      # };

      # screenshot = {
      #     package = screenshot-nvim;
      #     setup = "require('screenshot-nvim').setup {clipboard=true}";
      # };
    };
  };
}
