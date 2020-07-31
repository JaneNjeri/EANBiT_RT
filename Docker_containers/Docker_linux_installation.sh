#Add the Docker Repositories
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
apt-cache policy docker-ce
#Install Docker on Ubuntu 18.04
sudo apt install docker-ce
sudo systemctl status docker
#Check Docker Status
sudo systemctl status docker




#restarting docker
#sudo systemctl restart docker