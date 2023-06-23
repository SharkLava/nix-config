{ pkgs, ... }: {
  environment.systemPackages = with pkgs;[
    nodejs
    nodePackages.typescript-language-server
    nodePackages.js-beautify

  ];
}
