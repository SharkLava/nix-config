{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nasm
    qemu
    imhex
  ];
}
