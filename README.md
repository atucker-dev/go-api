# Simple Go API

## Summary

Quick starter shell Go API that use the [Fiber V2](https://docs.gofiber.io/) web framework and self signed certs

## Endpoints

- <https://localhost:3001/api> - if running outside Docker
- <https://localhost:8443/api> - if running within Docker
- `curl https://localhost:3001/api`

### Notes

Requires setting `TLS_CERT` and `TLS_KEY` environment variables as PEM files (Fiber wants PEM vs DER)

```bash
export TLS_CERT="./certs/tls-cert.pem"
export TLS_KEY="./certs/tls-key.pem"
```

```docker
docker run -v ./certs/tls-cert.pem:/certs/tls-docker-cert.pem \
           -v ./certs/tls-key.pem:/certs/tls-docker-key.pem \
           -e TLS_CERT=/certs/tls-docker-cert.pem \
           -e TLS_KEY=/certs/tls-docker-key.pem \
           -p 8443:3001 --rm <image-name>
```
