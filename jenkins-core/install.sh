# Based on instructiions at https://www.microsoft.com/net/download/linux-package-manager/debian9/sdk-current
# Install dependency for .NET Core 2.2.203-1 .NET Core 3.0
apt-get update
apt-get install -y curl libunwind8 gettext apt-transport-https sudo

# Based on instructions at https://www.microsoft.com/net/download/linux-package-manager/debian9/sdk-current
# Install microsoft.qpg & Install the .NET Core framework 

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget -q https://packages.microsoft.com/config/debian/9/prod.list
mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
chown root:root /etc/apt/sources.list.d/microsoft-prod.list

apt-get update
# wget http://ftp.cn.debian.org/debian/pool/main/i/icu/libicu63_63.1-6+deb10u3_amd64.deb
# sudo dpkg -i libicu63_63.1-6+deb10u3_amd64.deb
# apt-get install -y dotnet-sdk-2.2=2.2.203-1
apt-get install -y dotnet-sdk-3.1
apt-get install -y dotnet-sdk-5.0
apt-get clean


# apt-get update
# apt-get install -y curl libunwind8 gettext apt-transport-https sudo

# wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
# sudo dpkg -i packages-microsoft-prod.deb
# rm packages-microsoft-prod.deb

# sudo apt-get update && sudo apt-get install -y dotnet-sdk-6.0

