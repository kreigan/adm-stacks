# Description

A base Docker Compose configuration for Gluetun + qBittorrent with ProtonVPN Wireguard
setup and port forwarding enabled.

- Port forwarding requires a ProtonVPN Plus subscription
- qBittorrent must be configured to allow passwordless localhost connections to WebUI
for port forwarding to work. For new installations, put a default config file in
`$QBT_CONFIG/qBittorrent/config/qBittorrent.conf` with the following contents:

  ```ini
  [Preferences]
  WebUI\LocalHostAuth=false
  ```

- `/dev/net/tun` is required on the host for Wireguard to work

## Services

|Service|Image|Description|
|-|-|-|
|`gluetun`|`qmcgaw/gluetun`|A VPN client container using Gluetun.|
|`qbt`|`linuxserver/qbittorrent`|A qBittorrent client container.|

## Environment files and variables

Put the following variables in the respective environment files.

|File|Variable|Required|Default|Description|
|-|-|-|-|-|
|`gluetun.env`|`WIREGUARD_PRIVATE_KEY`|+||The Wireguard private key for ProtonVPN.|
|`gluetun.env`|`WIREGUARD_ENDPOINT_IP`|+||The Wireguard endpoint IP for ProtonVPN.|
|`gluetun.env`|`WIREGUARD_PUBLIC_KEY`|+||The Wireguard public key for ProtonVPN.|
|`gluetun.env`|`WIREGUARD_ADDRESSES`|+||The Wireguard addresses for ProtonVPN.|
|`qbittorrent.env`|`PUID`||`1000`|The user ID for qBittorrent to run as inside the container.|
|`qbittorrent.env`|`PGID`||`1000`|The group ID for qBittorrent to run as inside the container.|

## Usage

Child stacks must provide the following environment variables in their `.env` file.
The file is implicitly read by Docker Compose.

|Variable|Description|
|-|-|
|`QBT_CONFIG`|The path to the qBittorrent configuration directory on the host.|
|`QBT_DOWNLOADS`|The path to the qBittorrent downloads directory on the host.|

## Example

```text
stacks
├── 10-example-gluetor
│   ├── docker-compose.yaml
│   └── .env
└── common
    └── gluetor
        ├── gluetor-base.yaml
        |...
```

docker-compose.yaml:

```yaml
services:
  gluetun:
    extends:
      file: &base ../common/gluetor/gluetor-base.yaml
      service: gluetun

  qbt:
    extends:
      file: *base
      service: qbt
```

.env:

```env
QBT_CONFIG=/path/to/qbt/config
QBT_DOWNLOADS=/path/to/qbt/downloads
```
