{
  description = "Home Manager configurations";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, homeManager }:
    let
        system = "aarch64-darwin";
    in {
      homeConfigurations = {
        "axis" = homeManager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
            {
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
