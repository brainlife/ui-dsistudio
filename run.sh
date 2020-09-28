#!/bin/bash
./build.sh

echo "running vnc server"
docker stop vncserver
docker rm vncserver

password=$RANDOM.$RANDOM.$RANDOM
echo "password: $password"

echo "docker run -dP --name vncserver -v `pwd`/test:/input:ro $name"
id=$(docker run -dP --name vncserver -e X11VNC_PASSWORD=$password -v `pwd`/test:/input:ro brainlife/ui-mricrogl)
hostport=$(docker port $id | cut -d " " -f 3)
echo "container $id using $hostport"

WEBSOCK_HOSTPORT=0.0.0.0:11050

docker logs -f $id &

echo "------------------------------------------------------------------------"
echo "http://dev1.soichi.us:11050/vnc_lite.html?password=$password"
echo "------------------------------------------------------------------------"
cd /usr/local/noVNC && ./utils/launch.sh --listen $WEBSOCK_HOSTPORT --vnc $hostport > /tmp/nonvc.log

docker rm -f vncserver
