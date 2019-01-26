systemctl stop firewalld && systemctl disable firewalld

2049
111
2061
20048

yum -y install nfs-utils && systemctl start rpcbind nfs-server && systemctl enable rpcbind nfs-server

echo '/root/workspace/ci/data 172.27.16.3(rw,async,all_squash)' >> /etc/exports

showmount -e
firewall-cmd --add-service=nfs --permanent
firewall-cmd --reload

mount 172.27.16.3:/root/workspace/ci/data/client /root/workspace/app/app
umount -l /root/workspace/app/app