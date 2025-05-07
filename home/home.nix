{ config, pkgs, ... }:

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

  # User-wide options can be set here.
  # Example:
  # home.username = "your-username";
  # home.homeDirectory = "/home/your-username";

  # Set the Home Manager state version for migration safety.
  home.stateVersion = "24.05";
}
