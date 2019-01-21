curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh --mirror Aliyun
systemctl enable docker
systemctl start docker

mkdir jenkins_home
chown 1000 jenkins_home
yum -y install epel-release python-pip
pip install --upgrade pip
pip install docker-compose --ignore-installed requests
docker-compose up -d

sleep 25
echo `docker logs jenkins-core_jenkins-core_1`
