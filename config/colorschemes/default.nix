{
  lib,
  config,
  ...
}: {
  imports = [
    ./base16.nix
    ./catppuccin.nix
    ./gruvbox-material.nix
    ./rose-pine.nix
  ];

  options = {
    colorschemes.enable = lib.mkEnableOption "Enable colorschemes module";
  };
  config = lib.mkIf config.colorschemes.enable {
    base16.enable = lib.mkDefault false;
    catppuccin.enable = lib.mkDefault false;
    gruvbox-material.enable = lib.mkDefault true;
    rose-pine.enable = lib.mkDefault false;
  };
}
