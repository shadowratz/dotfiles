{ config, pkgs, ... }:

let
  hostImport =
    if pkgs.stdenv.isLinux then ./hosts/linux.nix
    else if pkgs.stdenv.isDarwin then ./hosts/macos.nix
    else null;
in
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
    ./hosts/linux.nix
    ./hosts/macos.nix
  ];

  # Set username and home directory from environment variables
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # Set the Home Manager state version for migration safety.
  home.stateVersion = "24.05";
}
