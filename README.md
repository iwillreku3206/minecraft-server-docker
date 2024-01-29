# Minecraft Server Docker

This is a Docker image for a Minecraft server, with support for [`ngrok`](https://ngrok.com/) for easy access to the server from anywhere.

## Usage

### Docker

```bash
docker run -d \
  -p 25565:25565 \
  -p 25575:25575 \
  -e NGROK_AUTHTOKEN=<token> \
  -e NGROK_REGION=<region> \
  -e NGROK_ENABLED=true \
  -e JAVA_VERSION=17 \
  -e JAVA_MEMORY_ALLOCATION=4G \
  -v /path/to/minecraft/server:/data \
  --restart unless-stopped \
  iwillreku3206/minecraft-server
```

## Environment Variables
| Variable | Description | Default |
| --- | --- | --- |
| `NGROK_AUTHTOKEN` | The auth token for ngrok. | `""` |
| `NGROK_REGION` | The region for ngrok. | `"na"` |
| `NGROK_ENABLED` | Whether or not to enable ngrok. | `false` |
| `JAVA_VERSION` | The version of Java to use. | `8` |
| `JAVA_MEMORY_ALLOCATION` | The amount of memory to allocate to the server. | `4G` |
| `OVERRIDE_START_SCRIPT` | Override start script with a custom script | `""`|

## Volumes
| Volume | Description |
| --- | --- |
| `/data` | The directory where the server files are stored. |

## Ports
| Port | Description |
| --- | --- |
| `25565` | The port for the Minecraft server. |
| `25575` | The port for the Minecraft RCON server. |
