{ inputs, lib, config, pkgs, ... }: {
  imports = [
  ];

  nixpkgs = {
    #overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "paper";
    homeDirectory = "/home/paper";
  };

  home.packages = [
    inputs.dotfiles.nvim.x86_64-linux.default
  ]

  xdg.configFile."nvim".source = inputs.dotfiles.nvim.configDir

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
