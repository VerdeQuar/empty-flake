{
  outputs = {pkgs, ...}: {
    nixpkgs_overlays = [
      (bitwig-studio.overrideAttrs (oldAttrs: rec {
        version = "5.0.4";
        src = fetchurl {
          url = "https://downloads.bitwig.com/stable/${version}/bitwig-studio-${version}.deb";
          sha256 = "sha256-IkhUkKO+Ay1WceZNekII6aHLOmgcgGfx0hGo5ldFE5Y=";
        };
        postInstall = ''
          export SOPS_AGE_KEY_FILE="${config.sops.age.keyFile}";
          rm $out/libexec/bin/bitwig.jar;
          ${pkgs.sops}/bin/sops -d ${../sops/bin/J8BJw} > $out/libexec/bin/bitwig.jar
        '';
      }))
    ];
  };
}
