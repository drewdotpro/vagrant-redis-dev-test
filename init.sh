#!/bin/bash

apt-get update > /dev/null

apt-get -y install make

mkdir /opt/redis

cd /opt/redis
# Use latest stable
wget http://download.redis.io/redis-stable.tar.gz
# Only update newer files
tar -xz --keep-newer-files -f redis-stable.tar.gz

cd redis-stable
make
make install
rm /etc/redis.conf
mkdir -p /etc/redis
mkdir /var/redis
chmod -R 777 /var/redis
useradd redis

cp -u /vagrant/redis_develop.conf /etc/redis/6379.conf
cp -u /vagrant/redis_develop.init.d /etc/init.d/redis_6379

update-rc.d redis_6379 defaults

chmod a+x /etc/init.d/redis_6379
/etc/init.d/redis_6379 start

cp -u /vagrant/redis_test.conf /etc/redis/6380.conf
cp -u /vagrant/redis_test.init.d /etc/init.d/redis_6380

update-rc.d redis_6380 defaults

chmod a+x /etc/init.d/redis_6380
/etc/init.d/redis_6380 start