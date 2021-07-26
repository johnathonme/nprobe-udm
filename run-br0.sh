podman run -d --net=host --restart always \
   --name nprobebr0 \
   -v /mnt/data_ext/ntopng/GeoIP.conf:/etc/GeoIP.conf \
   -v /mnt/data_ext/nprobe/nprobe-br0.conf:/etc/nprobe/nprobe.conf \
   -v /mnt/data_ext/nprobe/lib:/var/lib/nprobe \
   localhost/nprobe-udm:latest

podman logs nprobe
