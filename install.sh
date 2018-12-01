#!/bin/bash
# auth : gfw-breaker

rpm -ihv http://installrepo.kaltura.org/releases/kaltura-release.noarch.rpm
yum install -y kaltura-nginx

rm -fr /etc/nginx/conf.d/*

mkdir -p /usr/local/nginx/content/cache
mkdir -p /usr/share/nginx/html

server_ip=$(ifconfig | grep "inet addr" | sed -n 1p | cut -d':' -f2 | cut -d' ' -f1)

for f in $(ls sites); do
	sed -i "s/local_server_ip/$server_ip/g" sites/$f
done

cp common/* /etc/nginx/
cp sites/* /etc/nginx/conf.d

mv /etc/init.d/kaltura-nginx /etc/init.d/nginx

chkconfig nginx on
service nginx restart

