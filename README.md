# docker-tor-privoxy

Small docker image with Tor and Privoxy on Alpine Linux.

```bash
# Build the image:
docker build -t cviorel/tor-privoxy -f Dockerfile .


# Run it:
docker run -d \
  -p 8118:8118 \
  -p 9050:9050 \
  --name tor-privoxy \
  --restart=unless-stopped \
  cviorel/tor-privoxy

# Test:
curl --socks5 http://localhost:9050 -L http://ifconfig.me
curl --socks5 http://localhost:9050 -L https://check.torproject.org/api/ip
```
