{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions.enable = true;

    # Plugins: replicate Oh My Zsh plugins with home-manager equivalents where possible
    plugins = [
      "git"
      "rails"
      "terraform"
    ];

    shellAliases = {
      lg = "lazygit";
      lzd = "lazydocker";
      zed = "zed-preview";
      zel = "zellij";
    };

    # Use starship prompt
    initExtra = ''
      eval "$(starship init zsh)"
    '';

    # Custom configuration from .zshrc
    extraConfig = ''


      # Set Zed as the default editor
      export EDITOR="zed"
      export VISUAL="zed"

      # mise and zoxide initialization
      eval "$(mise activate zsh)"
      eval "$(zoxide init zsh)"

      # Dart CLI completion (make path dynamic if possible)
      [[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && . "$HOME/.dart-cli-completion/zsh-config.zsh" || true

      # 1Password CLI plugin (make path dynamic if possible)
      if [ -f "$HOME/.config/op/plugins.sh" ]; then
        source "$HOME/.config/op/plugins.sh"
      fi
    '';
  };

  programs.starship = {
    enable = true;
    # Optionally, you can specify a custom config file:
    # settings = { };
  };
}
