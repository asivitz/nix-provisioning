# nix run --impure github:nix-community/home-manager#home-manager --no-write-lock-file -- switch --flake ".#axis"
nix run --impure home-manager/release-23.05 --no-write-lock-file -- switch --flake .#$USER
# nix run --impure home-manager/master -- switch --flake .#$USER
