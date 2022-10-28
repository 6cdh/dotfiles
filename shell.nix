{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    stylua
    luajitPackages.luacheck
    sumneko-lua-language-server
  ];
}

