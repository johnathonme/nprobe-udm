#!/bin/bash

# This Script File builds the container and then copies it to the UDM

# Build - Tested on RPi4b with 8GB of RAM running Ubuntu 20.04
docker buildx build --platform linux/arm64 -t nprobe-udm:latest --load .


docker save -o ./nprobe-udm.tar nprobe-udm:latest 
scp nprobe-udm.tar  root@HOSTNAMEOFUDMPRO:~/

# Config Files for the container
tar cvf nprobe-files.tar GeoIP.conf run.sh


##############################################################################################
#  After the tar file is copied to the udm-pro login to  your UDM Pro and run these commands:
# podman load -i nprobe-udm.tar localhost/nprobe-udm:latest
# podman run -d --net=host --restart always \
#   --name nprobe \
#   -v /mnt/data_ext/nprobe/GeoIP.conf:/etc/GeoIP.conf \
#   -v /mnt/data_ext/nprobe/nprobe.conf:/etc/nprobe/nprobe.conf \
#   -v /mnt/data_ext/nprobe/lib:/var/lib/nprobe \
#   localhost/nprobe-udm:latest
# podman logs nprobe

# To stop, remove and cleanup run these commands on your UDM Pro
# podman stop nprobe
# podman rm nprobe
# podman rmi localhost/nprobe-udm:latest
# podman images
