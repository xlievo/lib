#!/bin/bash

docker run -d --name=gogs -p 10022:22 -p 10080:3000 -v /root/workspace/gogs:/data gogs/gogs