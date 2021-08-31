FROM openwrtorg/rootfs:19.07.8

ENV HOSTNAME OpenWrt
COPY root/init /init
COPY root/etc/shadow /etc/shadow
COPY root/etc/config/network /etc/config/network
COPY root/etc/config/firewall /etc/config/firewall
