
There is three docker images:
+ server (MC server)
  + java systemless distro
  + MC server (25565 game,25575 RCON)
+ server proxy
  + wireguard image
  + wireguard peer
  + Nat and forward (any incoming by peer tunnel to MC server)
+ remote proxy (different docker network )
  + wireguard image
  + wireguard server
  + Has public ip
  + Nat and forward (any incoming from internet to peer(server proxy))

Why?:
We had one server with great specs, but without public ip.
Creating private network like hamachi, would reduce number of players, we are quiet concerned about security.
Second server with public ip is not power-full enough to run server, but good enough for vpn. Not having to manual install all dependencies was a point, so we used docker.


WARNING: Due to wsl limitation (It don't have required modules), proxies work only on linux docker, or if you recompile wsl images manually.

SETUP SHORT:
Replace all \<REDACTED\> in config.bash.
Run init_setup.bash and copy two files form running container
wg0.conf i peer1.conf from /wg/wg_confs.
Place wg0.conf into project remote_proxy/wg_confs
Place peer1.conf into project server_proxy/wg_confs
Copy from appropriate example file PostUp i PostDown (it enables forwarding) (example can't be in same folder or wirequard will try to setup tunnel with <REDACTED> information)

Run setup_remote.bash to create images for remote_proxy. (dependency wg0.conf)
Run setup_local.bash to create images for server_proxy and server. (dependency peer1.conf)

You can create both images on local computer and later send image to destination pc.

More secure way is to create image directly on destination PC. (Remember we added keys to images).

To start containers form you can use start_local.bash and start_remote.bash. (Note we need special permissions)




HOW IT WORK:
Create network for server and server proxy
```
docker network create -d bridge --subnet=172.20.0.0/16 --opt com.docker.network.driver.mtu=1420 server-mc-network
```
sometimes you would need to change mtu (wireguard mtu is lower than default docker mtu)

