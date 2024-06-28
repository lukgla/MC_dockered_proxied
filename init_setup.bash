source config.bash #load env

#create network
docker network create -d bridge --subnet=172.20.0.0/16 --opt com.docker.network.driver.mtu=1420 $DOCKER_NETWORK_NAME

# use image to generate secrets
docker run --rm -it --name config_creator \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SERVERURL=$EXTERNAL_IP `#optional` \
  -e SERVERPORT=51820 `#optional` \
  -e PEERS=1 `#optional` \
  -e PEERDNS=auto `#optional` \
  -e INTERNAL_SUBNET=10.13.13.0 `#optional` \
  -e ALLOWEDIPS=0.0.0.0/0 `#allow all` \
  -e PERSISTENTKEEPALIVE_PEERS=all `#needed we are behind nat look example` \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  lscr.io/linuxserver/wireguard:latest