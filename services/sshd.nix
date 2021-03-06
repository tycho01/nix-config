{
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    allowSFTP = true;
    forwardX11 = true;
    openFirewall = true;
    gatewayPorts = "no";
    permitRootLogin = "no";

    # Only pubkey auth
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
    authorizedKeysFiles = [ ".ssh/id_rsa.pub" ];

    listenAddresses = [
      { addr = "0.0.0.0"; port = 22; }
    ];

    # usage:
    # ssh -R tycho01:22:localhost:22 serveo.net
    # ssh -J serveo.net tycho@tycho01
  };
}
