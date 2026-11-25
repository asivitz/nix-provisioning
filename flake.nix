{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    homeManager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, homeManager }:
    let
        system = "aarch64-darwin";
        overlays = [];
        # overlays = [ neovim-nightly-overlay.overlay ];
        # pkgs = import nixpkgs {
        #   inherit system overlays;
        # };
    in {
      homeConfigurations = {
        "axis" = homeManager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            {
              nixpkgs.overlays = overlays;
              home = {
                username = "axis";
                homeDirectory = "/Users/axis";
                stateVersion = "22.05";
              };
            }
          ];
        };
      };
    };
}
