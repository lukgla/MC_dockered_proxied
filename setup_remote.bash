source config.bash

docker build --file=dockerfile -t $DOCKER_USER/$REMOTE_PROXY_NAME ./remote_proxy
