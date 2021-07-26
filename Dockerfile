FROM debian:buster-slim

COPY entrypoint.sh /entrypoint.sh

COPY usr/bin/nprobe* /usr/bin/
COPY nprobe.license /etc/

#RUN  mkdir -p /usr/local/lib/nprobe/plugins
#COPY lib/plugins/* /usr/local/lib/nprobe/plugins/

RUN apt-get update \
        && apt-get --no-install-recommends -y install libcurl4 libpcap0.8 \
            libssl1.1 lsb-release ethtool libcap2 bridge-utils libnetfilter-conntrack3 libzstd1 libmaxminddb0 \
            libradcli4 libjson-c3 libsnmp30 udev libzmq5 libcurl3-gnutls net-tools curl procps \
        && rm -rf /var/lib/apt/lists/* \
        && curl -Lo /tmp/geoipupdate_2.3.1-1_arm64.deb  http://ftp.us.debian.org/debian/pool/contrib/g/geoipupdate/geoipupdate_2.3.1-1_arm64.deb \
        && dpkg -i /tmp/*.deb && rm /tmp/*.deb 

RUN  chmod +x /usr/bin/nprobe* \
     && mkdir /etc/nprobe \
     && echo "-i=br0\n-n=none\n--zmq=tcp://*:5557\n-T=@NTOPNG@" >> /etc/nprobe/nprobe.conf  \
     && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
