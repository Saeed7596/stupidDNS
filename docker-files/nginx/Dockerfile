FROM nginx:latest

RUN apt update && apt install -y iproute2 iputils-ping && apt clean all

COPY tun2proxy-bin /usr/bin/tun2proxy-bin
COPY warp-plus /usr/bin/warp-plus
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /app/start.sh

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD bash -c 'if [[ $(curl -s -o /dev/null -w "%{http_code}" https://www.docker.com/) -eq 200 ]]; then exit 0; else exit 1; fi'

CMD ["/bin/bash", "/app/start.sh"]

