{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-headers
    vulkan-loader
    bottles

    # melonDS
    # citra-nightly
    lutris
    ryujinx
    cartridges
    wineWowPackages.wayland
    melonDS

  ];
}
