# nvf

This is my custom (and very basic) neovim config managed with [nvf](https://github.com/NotAShelf/nvf) as a standalone flake. I use this config by importing it into my [nix-config](https://github.com/aleksanderbl29/nix-config).

## Note to self

When updating this config, remember to update the input in your nix-config. You can run the below command to do it manually, or wait for the Github Action to run weekly.

```zsh
cd ~/nix-config
nix flake lock --update-input nvf
```
