{ config
, pkgs
, username ? null
, homeDirectory ? null
, ...
}:

{
  # Main home-manager configuration entry point.
  # Import modules for each tool and OS-specific overrides.

  imports = [
    ./modules/zsh.nix
    ./modules/alacritty.nix
    ./modules/zellij.nix
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/zed.nix
    ./hosts/macos.nix
    ./hosts/linux.nix
  ];

  # Set username and home directory, with fallback to environment variables
  home.username = username or (builtins.getEnv "USER");
  home.homeDirectory = homeDirectory or (builtins.getEnv "HOME");

  # Set the Home Manager state version for migration safety.
  home.stateVersion = "24.05";
}
