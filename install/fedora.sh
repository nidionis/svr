sudo dnf -y install make
sudo dnf -y install gcc

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh --dry-run
rm get-docker.sh
curl -fsSL https://test.docker.com -o test-docker.sh
sudo sh test-docker.sh
sudo usermod -aG docker presk0
newgrp docker
#https://docs.docker.com/engine/install/linux-postinstall/
sudo yum install ruby
sudo yum install ruby-devel
gem update
