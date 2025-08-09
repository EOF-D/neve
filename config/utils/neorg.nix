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
    plugins = {
      neorg = {
        enable = true;
        telescopeIntegration.enable = true;
        settings = {
          load = {
            "core.defaults" = {
              __empty = null;
            };
            "core.concealer" = {
              config = {
                icon_preset = "varied";
              };
            };
            "core.dirman" = {
              config = {
                workspaces = {
                  notes = "~/neorg/notes";
                  work = "~/neorg/work-notes";
                };
              };
            };
            "core.keybinds" = {
              config = {
                default_keybinds = true;
              };
            };
          };
        };
      };

      treesitter = {
        grammarPackages = with pkgs.tree-sitter-grammars; [
          tree-sitter-norg
          tree-sitter-norg-meta
        ];
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>nn";
        action = "<cmd>Neorg workspace notes<cr>";
        options = {
          desc = "Open notes workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nw";
        action = "<cmd>Neorg workspace work<cr>";
        options = {
          desc = "Open work workspace";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nr";
        action = "<cmd>Neorg return<cr>";
        options = {
          desc = "Return from neorg";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>nt";
        action = "<cmd>Neorg toc<cr>";
        options = {
          desc = "Open table of contents";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader><CR>";
        action = "<plug>(neorg.qol.todo-items.todo.task-cycle)";
        options = {
          desc = "Switch the task under the cursor between a select few states";
          silent = true;
        };
      }
    ];
  };
}
