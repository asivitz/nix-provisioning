{ config, lib, pkgs, ... }:

{
  home.stateVersion = "22.05";

  home.packages = with pkgs; [
    # Some basics
    coreutils
    curl
    wget

    # haskellPackages.cabal-install
    # haskellPackages.hpack
    # haskellPackages.implicit-hie
    stack

    neovim
    ripgrep
    alacritty
    zsh
    oh-my-zsh
    zsh-z
    fd
    tmux
    reattach-to-user-namespace
    autoconf
    automake
    python3Full
    nodePackages.npm
    nodejs
  ];

  # Misc configuration files --------------------------------------------------------------------{{{

  # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  # home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
  #   templates = {
  #     scm-init = "git";
  #     params = {
  #       author-name = ""; # config.programs.git.userName;
  #       author-email = ""; # config.programs.git.userEmail;
  #       github-username = "";
  #     };
  #   };
  #   nix.enable = true;
  # };

}
