{
    description = "Flake for Warcraft Logs Uploader";
    inputs.nixpkgs.url = "github:NixOS/nixpkgs";
    outputs = { self, nixpkgs }:
    let
        eachSystem = systems: f:
        nixpkgs.lib.genAttrs systems (system:
        f {
            inherit system;
            pkgs = import nixpkgs { inherit system; };
        });
        supportedSystems = [ "x86_64-linux" ];
    in
    {
        packages = eachSystem supportedSystems ({ pkgs, system }: {
            default = pkgs.callPackage ./pkgs/warcraftlogs/default.nix {};
            warcraftlogs = pkgs.callPackage ./pkgs/warcraftlogs/default.nix {};
        });
    };
}