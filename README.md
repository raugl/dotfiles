# Dev dotfiles

Set up dev environment with all the basic CLI apps.

You need to have `git` and `curl` installed, then follow these steps:
```sh
# Step 1: Clone the repo
git clone https://github.com/raugl/dotfiles.git ~/.dotfiles

# Step 2: Install the nix package manager
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

# Step 3: Bootstrap home-manager
nix run github:nix-community/home-manager -- switch --flake ~/.dotfiles

# TODO: Change to the shell installed with nix
# Step 4 (recommended): Set your login shell to fish
sudo chsh /usr/bin/fish
```
