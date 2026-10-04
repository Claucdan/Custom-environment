{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop.nix
    ../../modules/hardware.nix
    ../../modules/packages
    ../../modules/system.nix
    ../../modules/users.nix
  ];

  networking.hostName = "nixos";

  # Windows uses a separate ESP on the NVMe drive. systemd-boot discovers
  # Windows automatically when its EFI files are present on our ESP.
  boot.loader.systemd-boot.extraInstallCommands = ''
    (
      set -eu
      windows_esp=$(${pkgs.coreutils}/bin/mktemp -d)
      trap '${pkgs.coreutils}/bin/rmdir "$windows_esp"' EXIT
      ${pkgs.util-linux}/bin/mount -t vfat -o ro \
        /dev/disk/by-partuuid/ce1c99b8-19d9-4d46-9001-82aaf5235bc3 "$windows_esp"
      trap '${pkgs.util-linux}/bin/umount "$windows_esp"; ${pkgs.coreutils}/bin/rmdir "$windows_esp"' EXIT
      test -f "$windows_esp/EFI/Microsoft/Boot/bootmgfw.efi"
      ${pkgs.coreutils}/bin/cp -r "$windows_esp/EFI/Microsoft" /boot/EFI/
    )
  '';

  # Keep this at the version used during the initial installation.
  system.stateVersion = "26.05";
}
