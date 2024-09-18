{pkgs, ...}:
let
  relativeXDGConfigPath = ".config";
  relativeXDGDataPath = ".local/share";
  relativeXDGCachePath = ".cache";
in
{
  programs = {
    starship = {
      enable = true;
      package = pkgs.starship;
      settings = {
        add_newline = false;
        format = pkgs.lib.concatStrings [
           "$username"
           "$hostname"
           "$localip"
           "$directory"
           "$git_branch"
           "$git_commit"
           "$git_state"
           "$git_metrics"
           "$git_status"
           "$nix_shell"
           "$env_var"
           # "$aws"
           "$cmd_duration"
           "$character"
         ];
         directory = {
           style = "yellow";
         };
         git_status = {
           stashed = "";
           style = "red";
         };
         git_branch = {
           format = "[$branch(:$remote_branch)]($style) ";
           style = "purple";
         };
         env_var = {
           variable = "NIXSHELL";
           format = "[$env_value]($style)";
           style = "green";
         };
         character = {
           success_symbol = "[\\$](bold yellow)";
           error_symbol = "[\\$](bold red)";
         };
         shell = {
          disabled = true;
         };
      };
    };

    git = {
      enable = true;
      difftastic.enable = true;
    };
    home-manager.enable = true;
    bat.enable = true;
    broot = {
      enable = true;
      enableZshIntegration = true;
    };
    neovim = {
      enable = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        vim-nix
        nvim-fzf
      ];
      extraConfig = builtins.readFile ./extraConfig.vim;
    };
    z-lua.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = false;
      history = {
        path = "/Users/axis/${relativeXDGDataPath}/zsh/.zsh_history";
        size = 50000;
        save = 50000;
      };
      shellAliases = import ./home/aliases.nix;
      initExtra = builtins.readFile ./home/extra.zsh;

      plugins = [
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
            sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
          };
        }
      ];
      prezto = {
        enable = true;
        color = true;
        editor = {
          keymap = "vi";
        };
      };
    };
  };
  xdg = {
    enable = true;
    configHome = "/Users/axis/${relativeXDGConfigPath}";
    dataHome = "/Users/axis/${relativeXDGDataPath}";
    cacheHome = "/Users/axis/${relativeXDGCachePath}";
  };

  home.file.".config/alacritty/alacritty.yml".source = ./home/alacritty.yml;

  home.packages = with pkgs;
    [ 
      coreutils
      curl
      wget

      #shell stuff

      ripgrep
      alacritty
      fd
      tmux
      reattach-to-user-namespace
      autoconf
      automake
      # python3Full
      # python311Packages.pip
      # python311Packages.pyaudio
      nodePackages.npm
      nodejs
      findutils

      sloccount
      du-dust

      # ormolu
      # stack
      # haskellPackages.cabal-install
      # haskellPackages.hpack
      # haskellPackages.implicit-hie
      cmake
      neovim-nightly
    ];
}
