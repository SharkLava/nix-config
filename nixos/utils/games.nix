{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-headers
    vulkan-loader
    bottles

    # melonDS
    citra-nightly
    ryujinx
    cartridges
    wineWowPackages.wayland
  ];
}
