{ config, lib, ... }:

{
  # Zellij home-manager module
  # This module manages Zellij configuration for your user.
  # Use home.file to symlink your Zellij config from the repo to ~/.config/zellij/config.kdl.
  # Only import this module on platforms where Zellij is supported.

  # Example: Symlink a zellij config file (uncomment and edit as needed)
  # home.file.".config/zellij/config.kdl".source = ./config.kdl;
}
