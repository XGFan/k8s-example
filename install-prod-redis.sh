#!/bin/bash

vagrant ssh master01 -c 'sudo apt install redis-server -y'
vagrant ssh master01 -c 'sudo sed -i "s/127.0.0.1/192.168.33.101/g" /etc/redis/redis.conf'
vagrant ssh master01 -c 'sudo service redis-server restart'
