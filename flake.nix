{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, homeManager }: {
    homeConfigurations = 
      let
        relativeXDGConfigPath = ".config";
        relativeXDGDataPath = ".local/share";
        relativeXDGCachePath = ".cache";
      in

    {
      "axis" = homeManager.lib.homeManagerConfiguration {
        configuration = {pkgs, ...}: {
          programs.home-manager.enable = true;
          programs.bat.enable = true;
          programs.neovim = {
            enable = true;
            viAlias = true;
            plugins = with pkgs.vimPlugins; [
              vim-nix
            ];
            extraConfig = builtins.readFile ./extraConfig.vim;
          };
          programs.z-lua.enable = true;
          programs.zsh = {
            enable = true;
            enableCompletion = true;
            enableAutosuggestions = false;
            history = {
              path = "${relativeXDGDataPath}/zsh/.zsh_history";
              size = 50000;
              save = 50000;
            };
            shellAliases = import ./home/aliases.nix;
            # defaultKeymap = "emacs";
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
              prompt = {
                theme = "skwp";
              };
              editor = {
                keymap = "vi";
              };
            };
          };

          home.packages = with pkgs;
            [ 
              coreutils
              curl
              wget

              # haskellPackages.cabal-install
              # haskellPackages.hpack
              # haskellPackages.implicit-hie
              stack

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
        };

        system = "aarch64-darwin";
        homeDirectory = "/Users/axis";
        username = "axis";
        stateVersion = "21.11";
      };
    };
  };
}
