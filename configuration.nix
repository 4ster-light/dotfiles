{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Enable flakes and nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # System bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";

  # System-wide localization
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  console.keyMap = "es";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    })
  ];

  # Display server and desktop environment
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    desktopManager.gnome.enable = true;
    videoDrivers = [ "modesetting" ];
    xkb = {
      layout = "es";
      variant = "winkeys";
    };
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "aster";
  };
  services.libinput.enable = true;

  # Graphics drivers support
  hardware.graphics.enable = true;

  # Printing support
  services.printing.enable = true;

  # Audio configuration
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account configuration
  users.users.aster = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "4ster-light";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    fish
  ];

  programs.fish.enable = true;

  # Network and security tools
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "24.05";
}
