{ config, pkgs, ... }:

{
  # Waybar Home Manager module
  #
  # This module manages the configuration for the Waybar status bar.
  # - Use home.file to symlink your Waybar config and style files from your dotfiles repo.
  # - Only add Waybar to home.packages here if you want it on all platforms.
  #   Otherwise, prefer OS-specific package installation in hosts/linux.nix or hosts/macos.nix.
  #
  # Example (uncomment and adjust as needed):
  # home.file.".config/waybar/config".source = ../../waybar/.config/waybar/config.jsonc;
  # home.file.".config/waybar/style.css".source = ../../waybar/.config/waybar/style.css;

  # Add Waybar to your user packages if desired:
  # home.packages = with pkgs; [ waybar ];
}
