{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    packages."aarch64-darwin" = let
        neovimConfigured = (inputs.nvf.lib.neovimConfiguration {
          inherit (nixpkgs.legacyPackages."aarch64-darwin") pkgs;
          modules = [{
              config.vim = {
                # Enable custom theming options
                theme.enable = true;

                # Enable Treesitter
                # tree-sitter.enable = true;

                # Other options will go here. Refer to the config
                # reference in Appendix B of the nvf manual.
                # ...
              };
          }];
        });
    in {
      # Set the default package to the wrapped instance of Neovim.
      # This will allow running your Neovim configuration with
      # `nix run` and in addition, sharing your configuration with
      # other users in case your repository is public.
      default = neovimConfigured.neovim;
    };
  };
}