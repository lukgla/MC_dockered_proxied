source config.bash

docker run -d \
  --name $SERVER_PROXY_NAME \
  --network=$DOCKER_NETWORK_NAME \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e LOG_CONFS=true `#optional` \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --ip=172.20.0.10 \
  $DOCKER_USER/$SERVER_PROXY_NAME

docker run -d \
  --name $SERVER_MC_NAME \
  --network=$DOCKER_NETWORK_NAME \
  --ip=172.20.0.30  \
  -v $MC_VOLUME:/mc  \
  -v $MC_WORD_VOLUME:/mc/word \
  -p 25565:25565 -p 25575:25575 \
  --entrypoint="java -jar minecraft_server.jar -Xmx$SERVER_MAX_RAM -Xms$SERVER_MIN_RAM nogui" \
  $DOCKER_USER/$SERVER_MC_NAME:$MC_VERSION
