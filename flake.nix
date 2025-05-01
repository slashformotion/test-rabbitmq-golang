{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "x86_64-darwin"
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];
    forAllSystems = function:
      nixpkgs.lib.genAttrs systems (system:
        function (
          import
          nixpkgs {
            inherit system;
            config.allowUnfree = true;
          }
        ));
  in {
    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        # nativeBuildInputs is usually what you want -- tools you need to run
        nativeBuildInputs = with pkgs; [
          gnumake

          go
          go-tools
          terraform
          terraform-ls
        ];
      };
    });
  };
}
