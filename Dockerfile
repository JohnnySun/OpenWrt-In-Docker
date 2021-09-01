FROM openwrtorg/rootfs:19.07.8

ENV HOSTNAME OpenWrt
COPY root/init /init
RUN mkdir -p /var/lock

RUN opkg update

RUN opkg remove dnsmasq
RUN opkg remove libcap --force-depends

ADD https://downloads.openwrt.org/snapshots/packages/x86_64/base/libcap_2.51-1_x86_64.ipk /tmp/libcap_2.51-1_x86_64.ipk
ADD https://downloads.openwrt.org/snapshots/packages/x86_64/base/libcap-bin_2.51-1_x86_64.ipk /tmp/libcap-bin_2.51-1_x86_64.ipk
RUN opkg install /tmp/libcap_2.51-1_x86_64.ipk /tmp/libcap-bin_2.51-1_x86_64.ipk
RUN opkg install luci-theme-material coreutils-nohup bash iptables dnsmasq-full curl jsonfilter ca-certificates ipset ip-full iptables-mod-tproxy iptables-mod-extra libcap libcap-bin ruby ruby-yaml
ADD https://github.com/vernesong/OpenClash/releases/download/v0.43.01-beta/luci-app-openclash_0.43.01-beta_all.ipk /tmp/luci-app-openclash_0.43.01-beta_all.ipk
RUN opkg install /tmp/luci-app-openclash_0.43.01-beta_all.ipk
RUN opkg install luci-compat

RUN rm /tmp/libcap_2.51-1_x86_64.ipk /tmp/libcap-bin_2.51-1_x86_64.ipk /tmp/luci-app-openclash_0.43.01-beta_all.ipk

RUN rm -rf /var/lock

#COPY root/etc/shadow /etc/shadow
COPY root/etc/config/network /etc/config/network
#COPY root/etc/config/firewall /etc/config/firewall
