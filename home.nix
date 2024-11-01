{ config, pkgs, ... }:

let
  helixConfig = ''
    theme = "gruvbox"

    [editor]
    line-number = "relative"

    [editor.cursor-shape]
    insert = "bar"
    normal = "block"
    select = "underline"

    [editor.file-picker]
    hidden = false

    [editor.statusline]
    left = ["mode", "spinner", "diagnostics"]
    center = ["file-name"]
    right = ["selections", "position", "file-encoding", "file-type"]
    separator = "│"
    mode.normal = "NORMAL"
    mode.insert = "INSERT"
    mode.select = "SELECT"

    [editor.indent-guides]
    render = true
    character = "┆"
    skip-levels = 1

    [keys.normal]
    C-s = ":w" # Maps Ctrl-s to write
    C-q = ":wq" # Maps Ctrl-q to write-quit
    C-o = ":open ~/.config/helix/config.toml" # Maps Ctrl-o to opening of the helix config file
    C-r = ":config-reload" # Maps Ctrl-r to reloading the configuration
  '';

  kittyConfig = ''
    font_family JetBrainsMono Nerd Font
    font_size 12
    cursor_shape block
  '';
in
{
  home.username = "aster";
  home.homeDirectory = "/home/aster";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nixpkgs-fmt
    # == General ==
    neofetch
    vscode
    kitty
    brave
    helix
    # == Golang ==
    go
    gopls
    # == Lua ==
    lua
    luaPackages.luarocks
    # == Rust ==
    rustup
    # == Python ==
    python3
    python3Packages.pip
    virtualenv
    # == JS/TS ==
    bun
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -U fish_greeting ""

      if not test -d ~/.local/share/omf
        curl -L https://get.oh-my.fish | fish
      end

      if not omf theme | grep -q 'lambda'
        omf install lambda
        omf theme lambda
      end
    '';
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "4ster-light";
    userEmail = "davidvivarbogonez@gmail.com";
  };

  # Kitty configuration
  xdg.configFile."kitty/kitty.conf" = {
    text = kittyConfig;
    force = true;
  };

  # Helix configuration
  xdg.configFile."helix/config.toml" = {
    text = helixConfig;
    force = true;
  };
}
