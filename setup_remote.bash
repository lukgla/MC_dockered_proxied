source config.bash

docker build --file=./remote_proxy/dockerfile -t $DOCKER_USER/$REMOTE_PROXY_NAME ./remote_proxy
