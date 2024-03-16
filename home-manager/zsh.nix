{ ... }: {
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake .#Omen";
      upgrade = "sudo nixos-rebuild switch --flake .#Omen --upgrade-all";
    };
    history = {
      size = 10000;
      path = ".config/zsh/history";
    };

    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "direnv" ];
      theme = "robbyrussell";
    };
  };
}
