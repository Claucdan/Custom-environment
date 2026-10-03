{ ... }:

{
  users.users.hhhh = {
    isNormalUser = true;
    description = "main";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
