source config.bash

docker run -d \
  --name proxy \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SERVERURL=$EXTERNAL_IP `#optional` \
  -e SERVERPORT=51820 `#optional` \
  -e PEERS=0 `#optional` \
  -e PEERDNS=auto `#optional` \
  -e INTERNAL_SUBNET=10.13.13.0 `#optional` \
  -e ALLOWEDIPS=0.0.0.0/0 `#allow all` \
  -e PERSISTENTKEEPALIVE_PEERS=all `#needed we are behind nat look example` \
  -e LOG_CONFS=true `#optional` \
  -p 51820:51820/udp \
  -p 25565:25565 \
  -p 25575:25575 \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  $DOCKER_USER/$REMOTE_PROXY_NAME