{

  inputs = {
    # updated 2022-02-07
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      rev = "a102368ac4c3944978fecd9d7295a96d64586db5";
      narHash = "sha256-hgdcyLo2d8N2BmHuPMWhsXlorv1ZDkhBjq1gMYvFbdo=";
    };
  };


  outputs = { self, nixpkgs }: {

    defaultPackage.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stdenv.mkDerivation {
      name = "runcached";
      srcs = [
        ./Makefile
        ./src
      ];
      unpackPhase = ''
        for file in $srcs; do
          cp -r $file $(stripHash $file)
        done
      '';
      installFlags = [ "DESTDIR=$(out)" "PREFIX=/" ];
    };

  };

}
