{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    # TODO: Add plugins, aliases, and custom configuration here.
    # You can import existing .zshrc content as options or as extraConfig.
    # Example:
    # extraConfig = ''
    #   export EDITOR=zed
    #   # Add more custom Zsh config here
    # '';
  };
}
