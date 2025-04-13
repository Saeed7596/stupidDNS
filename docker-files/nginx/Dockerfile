FROM nginx:latest

RUN apt update && apt install -y iproute2 && apt clean all

COPY tun2proxy-bin /usr/bin/tun2proxy-bin
COPY warp-plus /usr/bin/warp-plus
COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /app/start.sh

CMD ["/bin/bash", "/app/start.sh"]
