{ pkgs, lib, ... }:

{
    vim = {
        theme = {
            enable = true;
            name = "oxocarbon";
            style = "dark";
        };

        extraPackages = with pkgs; [ python312Packages.jupytext ];
        terminal.toggleterm.enable = true;
        terminal.toggleterm.mappings.open = "<c-\\>";
        terminal.toggleterm.setupOpts.direction = "float";
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        useSystemClipboard = true;
        spellcheck.enable = true;
        spellcheck.ignoredFiletypes = ["toggleterm" "python" "julia" "nix"];

        utility.motion.leap.enable = true;

        mini.surround.enable = true;
        mini.pairs.enable = true;
        mini.move.enable = true;

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

        ];

        languages = {
            enableLSP = true;
            enableTreesitter = true;
            nix.enable = true;
            julia.lsp.package= null; # I disable this since I have julia installed on its own
            julia.enable = true;
            julia.lsp.enable = true;
            python.enable = true;
            python.format.enable = true;
            python.format.type = "ruff";
            python.lsp.server = "pyright";
        };

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
            };

            jupytext = {
                package = jupytext-nvim;
                setup = "require('jupytext').setup {}";
            };
        };

    };

}
