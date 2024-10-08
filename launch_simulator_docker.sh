#!/bin/bash

tmp_ips=$(hostname -I) # worst scenario: avahi-publish won't do its work...
tmp_array=($tmp_ips) 
avahi-publish -a -R carla-container.local ${tmp_array[0]} &>/dev/null &
export AVAHI_PUB_PID=$!
trap 'echo Killing avahi-publish with PID $AVAHI_PUB_PID && kill $AVAHI_PUB_PID' EXIT

docker run --rm -it \
--name gruppo1-carla-container \
--net host \
--user carla \
--gpus 0 \
carla:gruppo1 ./launch_headless.sh