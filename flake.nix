{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = inputs: {
    templates = {
      try = {
        path = ./template/try;
        description = ''
          A minimal flake for a try directory. Supports direnv as well. Post tasks:

          - Update .gitignore_sources
          - Run `mkignore` to generate the gitignore file
          - Update flake.nix
          - Run `nix flake lock` to generate the lock file
        '';
      };
    };
  };
}
