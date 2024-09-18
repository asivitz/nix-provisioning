{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    homeManager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, homeManager, neovim-nightly-overlay }:
    let
        system = "aarch64-darwin";
        overlays = [ neovim-nightly-overlay.overlay ];
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
