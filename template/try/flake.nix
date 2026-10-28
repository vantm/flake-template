{
  description = "Try template";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      eachSystem =
        systems: f:
        nixpkgs.lib.foldl' (
          acc: system:
          nixpkgs.lib.recursiveUpdate acc (
            nixpkgs.lib.mapAttrs (_: value: { ${system} = value; }) (f {
              inherit system;
              pkgs = import nixpkgs { inherit system; };
            })
          )
        ) { } systems;
      eachDefaultSystem = eachSystem [ "x86_64-linux" ];
    in
    eachDefaultSystem (
      { pkgs, ... }: {
        devShells.default = pkgs.mkShell {
          name = "Try template";
          packages = with pkgs; [
            hello
          ];
        };
      }
    );
}
