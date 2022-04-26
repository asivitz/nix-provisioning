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
    homeConfigurations = {
      "axis" = homeManager.lib.homeManagerConfiguration {
        configuration = import ./home.nix;

        system = "aarch64-darwin";
        homeDirectory = "/Users/axis";
        username = "axis";
        stateVersion = "21.11";
      };
    };
  };
}
