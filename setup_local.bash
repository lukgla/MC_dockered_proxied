source config.bash

docker build --file=./server/dockerfile -t $DOCKER_USER/$SERVER_MC_NAME:$MC_VERSION ./server
docker build --file=./server_proxy/dockerfile -t $DOCKER_USER/$SERVER_PROXY_NAME ./server_proxy