FROM jenkins/jenkins:2.235.3
RUN /usr/local/bin/install-plugins.sh publish-over-ssh gitee copyartifact #gogs-webhook

USER root
COPY install.sh install.sh
RUN bash install.sh
# Switch back to the jenkins user.
USER jenkins

# 整体参考：[如何建立含有 .NET Core SDK 的 Jenkins Docker Image ?](http://oomusou.io/docker/jenkins-core/#Dockerfile)
