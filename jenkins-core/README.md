# jenkins-core

[![](https://images.microbadger.com/badges/image/xlievo/jenkins-core.svg)](https://microbadger.com/images/xlievo/jenkins-core "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/xlievo/jenkins-core.svg)](https://microbadger.com/images/xlievo/jenkins-core "Get your own version badge on microbadger.com")

Original construction:

1. yum install git -y && git clone https://github.com/xlievo/lib.git && cd lib/jenkins-core && sh init.sh

2. Open ip:8180 on the browser 

3. vi jenkins_home/secrets/initialAdminPassword & Set the initialAdminPassword string to your jenkins page

Docker run:

mkdir -p /root/workspace/jenkins_home && chown -R 1000 /root/workspace/jenkins_home

docker run -d -u root --name ci --restart=always --privileged=true -p 50000:50000 -p 8180:8080 -v /root/workspace/jenkins_home:/var/jenkins_home xlievo/jenkins-core:latest

docker logs ci (View password)

dotnet restore
dotnet build
dotnet publish -c release -o /var/jenkins_home/data/app
