FROM alpine:edge

RUN apk --no-cache add dnsmasq \
    && mkdir -p /etc/dnsmasq.d/

COPY dnsmasq.conf /etc/dnsmasq.conf

ENTRYPOINT ["dnsmasq", "-d"]
