{ ... }: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .#Omen";
      upgrade = "sudo nixos-rebuild switch --flake .#Omen --upgrade-all";
    };
    history = {
      size = 10000;
      path = ".config/zsh/history";
    };


    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
      theme = "robbyrussell";
    };
  };
}
