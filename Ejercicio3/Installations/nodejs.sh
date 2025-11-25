#Actualizar repositorio de Ubuntu
sudo apt update -y

sudo apt upgrade

curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash - 

sudo apt-get install -y nodejs

sudo ufw allow https
sudo ufw allow http
sudo ufw allow ssh
sudo ufw --force enable

sudo tee myapp.js <<EOF
const http = require('http');

const hostname = 'localhost';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Mi nombre es Julio Cesar Gonzalez Hernandez, estudiante de la maestria DevOps en UNIR Mexico.\n');
});

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});
EOF

sudo npm install pm2@latest -g

pm2 start myapp.js
pm2 startup systemd
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu
pm2 save

sudo systemctl start pm2-ubuntu
pm2 stop myapp
pm2 restart myapp