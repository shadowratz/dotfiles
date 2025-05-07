{ config, pkgs, ... }:

{
  # Hyprland Home Manager module
  # This module manages the Hyprland window manager configuration for your user.
  # Use home.file to symlink your Hyprland config from your dotfiles repo to ~/.config/hypr/hyprland.conf.
  # Example (uncomment and adjust as needed):
  # home.file.".config/hypr/hyprland.conf".source = ../../hyprland/.config/hypr/hyprland.conf;
}
