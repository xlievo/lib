
echo "kernel.pid_max = 65535" >> /etc/sysctl.conf

sed -i '/^#DefaultLimitNOFILE=/aDefaultLimitNOFILE=65535' /etc/systemd/system.conf
sed -i '/^#DefaultLimitNPROC=/aDefaultLimitNPROC=65535' /etc/systemd/system.conf
echo "* soft nproc 65535"  >> /etc/security/limits.conf
echo "* hard nproc 65535"  >> /etc/security/limits.conf
echo "* soft nofile 65535"  >> /etc/security/limits.conf
echo "* hard nofile 65535"  >> /etc/security/limits.conf

vim /etc/security/limits.d/20-nproc.conf
*          soft    nproc     65535

echo 'vm.max_map_count=262144'>>/etc/sysctl.conf
sysctl -p

reboot
sysctl kernel.pid_max
ulimit -a

docker build -t elk:1.0 .

docker run --restart=always --privileged=true -u root -p 5601:5601 -p 9200:9200 -p 5044:5044 -p 6000:6379 -itd --name elk xlievo/elk:latest

docker exec -it elk bash

apt-get update && apt-get install -y wget gcc make sysv-rc-conf redis-server
cd /root && wget http://download.redis.io/releases/redis-stable.tar.gz && tar xzf redis-stable.tar.gz && cd redis-stable && make
mkdir /etc/redis
docker cp /root/redis.conf elk:/etc/redis/6379.conf
docker cp /root/redis_init_script elk:/etc/init.d/redis

chmod +x /etc/init.d/redis

update-rc.d redis defaults

update-rc.d redis-server defaults

chmod 777 /etc/init.d/redis && sysv-rc-conf redisd on

service redis start
service redis-server start

/root/redis-stable/src/redis-cli -a YwSqjBzs

/usr/bin/redis-cli

/root/redis-stable/src/redis-server /etc/redis/6379.conf

systemctl enable redis-server


./redis-server /root/redis-stable/redis.conf

rm -rf /etc/logstash/conf.d/*
vim /etc/logstash/conf.d/redis.conf

publish logstash "debug message !!!!"

input {
    redis {
        data_type => "pattern_channel"
        key => "logstash-*"
        host => "localhost"
        port => 6379
        password => "YwSqjBzs"
    }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "logstash-%{type}-%{+YYYY.MM.dd}"
    document_type => "%{type}"
    sniffing => true
    template_overwrite => true
  }
}


/etc/init.d/logstash restart