# CnCNet Tunnel Server Docker

A Docker project for deploying a CnCNet tunnel server.

- Built with .NET 10 NativeAOT
- Based on Alpine

## Configuration

Create a `.env` file in the project directory with the following content:

```env
# SERVER_NAME: Server name
SERVER_NAME="My CnCNet Tunnel"

# MAX_CLIENTS: Maximum clients per tunnel version
MAX_CLIENTS=200

# PORT1: Port for v3 tunnel
PORT1=50001

# PORT2: Port for v2 tunnel
PORT2=50000
```

## Usage

- Start: `docker compose up -d`
- Stop: `docker compose down`
- Logs: `docker compose logs -f -t`

## License

Licensed under the MIT License.
