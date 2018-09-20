#!/bin/bash
# auth : gfw-breaker

rm -fr /etc/nginx/conf.d/*

mkdir -p /usr/local/nginx/content/cache

server_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

for f in $(ls sites); do
	sed -i "s/local_server_ip/$server_ip/g" sites/$f
done

cp common/* /etc/nginx/
cp sites/* /etc/nginx/conf.d

chkconfig nginx on
service nginx restart


