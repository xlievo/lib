

echo 'vm.max_map_count=262144'>>/etc/sysctl.conf
/sbin/sysctl -p

sudo docker run --restart=always --privileged=true -p 5601:5601 -p 9200:9200 -p 5044:5044 -itd --name elk sebp/elk

docker exec -it elk /bin/bash

apt-get install -y wget gcc make
wget http://download.redis.io/releases/redis-5.0.3.tar.gz && tar xzf redis-5.0.3.tar.gz && cd redis-5.0.3 && make

vim /etc/logstash/conf.d/02-beats-input.conf

publish logstash-log "debug message !!!!"

input {
    redis {
        data_type => "channel"
        key => "logstash"
        host => "192.168.1.121"
        port => 5900
		password => "8l/3Etmi"
        batch_count => 1
        threads => 5
    }
}

output {
  elasticsearch {
    hosts => ["localhost"]
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}