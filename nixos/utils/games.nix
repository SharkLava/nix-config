{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vulkan-tools
    vulkan-headers
    vulkan-loader
    bottles
    cartridges
    wineWowPackages.wayland
  ];
}
