{ pkgs }:
pkgs.symlinkJoin {
  name = "appDependencies";
  paths = with pkgs; [
    inotifyTools
  ];
}
