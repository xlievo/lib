curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
systemctl enable docker
systemctl start docker

sudo docker rm -f $(sudo docker ps -aqf 'name=jenkins-core_jenkins-core_1')
sudo docker rmi -f $(sudo docker images --filter=reference='xlievo/jenkins-core:latest' -q)
sudo docker rmi -f $(sudo docker images --filter=reference='jenkins-core_jenkins-core:latest' -q)

mkdir jenkins_home
chown 1000 jenkins_home
yum -y install epel-release python-pip
pip install --upgrade pip
pip install docker-compose --ignore-installed requests
docker-compose up -d

sleep 25
echo `docker logs jenkins-core_jenkins-core_1`

sudo docker rmi -f $(sudo docker images --filter=reference='xlievo/jenkins-core:latest' -q)
sudo docker commit $(sudo docker ps -aqf 'name=jenkins-core_jenkins-core') xlievo/jenkins-core
sudo docker push xlievo/jenkins-core


