{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  environment.systemPackages = with pkgs; [
    neovim
    tree-sitter
    ripgrep
    gcc
    git
  ];

  time.timeZone = "America/Indianapolis";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.system-boot.enable = true;
  services.printing.enable = true;

  networking.hostName = "paper";

  users.users = {
    paper = {
      initialPassword = "123";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ];
      extraGroups = ["wheel", "networkmanager"];
    };
  };

  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PermitRootLogin = "no";
  #     PasswordAuthentication = false;
  #   };
  # };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
