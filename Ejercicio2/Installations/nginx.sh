sleep 30
sudo apt update
sudo apt install nginx -y
sudo systemctl start nginx

sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3000/tcp
sudo ufw --force enable

sudo systemctl enable nginx
