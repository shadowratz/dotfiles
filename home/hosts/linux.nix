{ config, pkgs, ... }:

{
  # Arch-specific home-manager configuration goes here.
  # Add packages, environment variables, or settings unique to Arch Linux.

  # Example: Install Hyprland and Waybar only on Arch
  home.packages = if pkgs.stdenv.isLinux then (with pkgs; [
    hyprland
    waybar
    nixd
    mise
    zoxide
  ]) else [];

  # You can import additional modules or set Arch-specific options here.
}
