{pkgs, ...}: {
  imports = [./cachix/cuda-maintainers.nix];
  environment.systemPackages = with pkgs; [
    cachix
  ];
}
