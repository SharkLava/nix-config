{pkgs, ...}: {
  environment.systemPackages = with pkgs.haskellPackages; [
    ghc
    haskell-language-server
    cabal-install
    fourmolu
  ];
}
