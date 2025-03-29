{
  services.dnscrypt-proxy = {
    overrideLocalDns = true;
    settings = {
      listen_addresses = [ "127.0.0.1:53000" ];
      doh_servers = true;
      dnscrypt_servers = true;
      server_names = [
        "adguard-dns"
        "adguard-dns-doh"
        "cloudflare"
        "cloudflare-security"
        "cloudflare-ipv6"
        "cloudflare-security-ipv6"
      ];
      sources.public-resolvers = {
        cache_file = "public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
        prefix = "";
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          "https://ipv6.download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
      };
      sources.relays = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/relays.md"
          "https://download.dnscrypt.info/resolvers-list/v3/relays.md"
          "https://ipv6.download.dnscrypt.info/resolvers-list/v3/relays.md"
        ];
        cache_file = "relays.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
        prefix = "";
      };
    };
  };

  services.unbound.settings = {
    server = {
      username = ''""'';
      verbosity = 3;
      interface = "127.0.0.1";
      port = 53;
      do-ip4 = "yes";
      do-ip6 = "no";
      do-udp = "yes";
      do-tcp = "yes";
      do-not-query-localhost = "no";
      access-control = "127.0.0.0/8 allow";
      cache-min-ttl = 3600;
      cache-max-ttl = 86400;
      msg-cache-size = "50m";
      rrset-cache-size = "100m";
      prefetch = "yes";
      hide-identity = "yes";
      hide-version = "yes";
      use-syslog = "yes";
      log-queries = "yes";
      log-replies = "yes";
    };

    forward-zone = {
      name = ''"."'';
      forward-first = "yes";
      forward-addr = [
        "127.0.0.1@53000"
      ];
    };
  };
}
