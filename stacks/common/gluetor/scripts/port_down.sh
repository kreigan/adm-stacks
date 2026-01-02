#!/usr/bin/env sh

# https://github.com/qdm12/gluetun-wiki/blob/main/setup/advanced/vpn-port-forwarding.md#qbittorrent-example
wget -O- \
    --retry-connrefused \
    --post-data 'json={ \
      "listen_port":0, \
      "current_network_interface":"lo" \
    }' \
    http://127.0.0.1:${WEBUI_PORT:-8080}/api/v2/app/setPreferences 2>&1
