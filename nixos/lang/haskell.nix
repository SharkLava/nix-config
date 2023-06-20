{ pkgs, ... }: {
  environment.systemPackages = with pkgs.haskellPackages; [
    ghc
    haskell-language-server
    cabal-install
    stack
    fourmolu

    # Packages
    gtk3
  ];
}
