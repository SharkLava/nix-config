{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.marksman
  ];
}
