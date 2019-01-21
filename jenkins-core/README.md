# jenkins-core
[![](https://images.microbadger.com/badges/image/xlievo/jenkins-core.svg)](https://microbadger.com/images/xlievo/jenkins-core "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/xlievo/jenkins-core.svg)](https://microbadger.com/images/xlievo/jenkins-core "Get your own version badge on microbadger.com")

1. yum install git -y && mkdir ci && cd ci && git clone https://github.com/xlievo/jenkins-core.git && cd jenkins-core && sh init.sh

2. Open ip:8180 on the browser 

3. vi jenkins_home/secrets/initialAdminPassword & Set the initialAdminPassword string to your jenkins page

docker run -d --name jenkins --restart=always --privileged=true -p 50000:50000 -p 8180:8080 xlievo/jenkins-core:latest
