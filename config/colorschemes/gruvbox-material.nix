{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    gruvbox-material.enable = lib.mkEnableOption "Enable gruvbox-material module";
  };
  config = lib.mkIf config.gruvbox-material.enable {
    extraPlugins = with pkgs.vimPlugins; [
      gruvbox-material
    ];

    # Set the colorscheme.
    colorscheme = "gruvbox-material";

    globals = {
      gruvbox_material_background = "medium";
      gruvbox_material_palette = "material";

      gruvbox_material_enable_bold = true;
      gruvbox_material_enable_italic = true;
      gruvbox_material_disable_italic_comments = false;
      gruvbox_material_transparent_background = true;
      gruvbox_material_show_eob = true;
      gruvbox_material_diagnostic_text_highlight = false;
      gruvbox_material_diagnostic_line_highlight = false;
      gruvbox_material_diagnostic_virtual_text = "grey";
      gruvbox_material_better_performance = true;

      gruvbox_material_cursor = "auto"; # "auto", "red", "orange", "yellow", "green", "aqua", "blue", "purple"
      gruvbox_material_sign_column_background = "none";
      gruvbox_material_float_style = "bright";
    };

    plugins = {
      treesitter.enable = true;
      telescope.enable = true;
      which-key.enable = true;
      gitsigns.enable = true;
      cmp.enable = true;
      neo-tree.enable = true;
      harpoon.enable = true;
      noice.enable = true;
      notify.enable = true;
      illuminate.enable = true;
      indent-blankline.enable = true;
      mini.enable = true;
    };
  };
}
