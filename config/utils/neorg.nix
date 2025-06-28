{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    neorg.enable = lib.mkEnableOption "Enable neorg module";
  };
  config = lib.mkIf config.neorg.enable {
    extraPlugins = with pkgs.vimPlugins; [
      neorg
      plenary-nvim
      nui-nvim
      nvim-nio
    ];

    plugins.treesitter = {
      enable = true;
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter; [
        (builtGrammars.tree-sitter-norg or pkgs.tree-sitter-grammars.tree-sitter-norg)
        (builtGrammars.tree-sitter-norg-meta or pkgs.tree-sitter-grammars.tree-sitter-norg-meta)
      ];
    };

    extraConfigLua = ''
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
                work = "~/work-notes",
              },
              default_workspace = "notes",
              index = "index.norg",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.integrations.nvim-cmp"] = {},
          ["core.export"] = {},
          ["core.export.markdown"] = {},
          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader>o",
            },
          },
          ["core.journal"] = {
            config = {
              workspace = "notes",
            },
          },
        },
      })

      vim.filetype.add({
        extension = {
          norg = "norg",
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "norg",
        callback = function()
          vim.opt_local.conceallevel = 2
          vim.opt_local.concealcursor = "nc"
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
        end,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.defer_fn(function()
            if vim.fn.exists(":Neorg") == 0 then
              vim.notify("Neorg commands not found. Check neorg installation.", vim.log.levels.ERROR)
            else
              vim.notify("Neorg loaded successfully!", vim.log.levels.INFO)
            end
          end, 500)
        end,
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>on";
        action = "<cmd>Neorg workspace notes<cr>";
        options = {
          desc = "Open notes workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ow";
        action = "<cmd>Neorg workspace work<cr>";
        options = {
          desc = "Open work workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>or";
        action = "<cmd>Neorg return<cr>";
        options = {
          desc = "Return from neorg";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>oj";
        action = "<cmd>Neorg journal today<cr>";
        options = {
          desc = "Open today's journal";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ot";
        action = "<cmd>Neorg toc<cr>";
        options = {
          desc = "Open table of contents";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>oi";
        action = "<cmd>Neorg index<cr>";
        options = {
          desc = "Open workspace index";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>oI";
        action = "<cmd>Neorg inject-metadata<cr>";
        options = {
          desc = "Inject metadata";
          silent = true;
        };
      }
    ];
  };
}
