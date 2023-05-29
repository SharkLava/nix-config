{pkgs, ...}: let
  myRPackages = with pkgs.rPackages; [
    devtools
    xfun
    xml2
    swirl
  ];
in {
  environment.systemPackages = with pkgs; [
    (rWrapper.override {packages = myRPackages;})
    (rstudioWrapper.override {packages = myRPackages;})
  ];
}
