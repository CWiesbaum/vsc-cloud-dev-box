#!/bin/bash
sudo -u vscdev systemctl --user enable code-server

%{ if exposed == "true" }
loginctl enable-linger vscdev

cat > /etc/nginx/conf.d/code-server.conf << EOF
server {
    listen 80;
    listen [::]:80;
    server_name ${domain};

    location / {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection upgrade;
        proxy_set_header Accept-Encoding gzip;
    }
}
EOF

chown nginx:nginx /etc/nginx/conf.d/code-server.conf
chmod 0640 /etc/nginx/conf.d/code-server.conf

certbot %{ if test_cert == "true" }--test-cert%{ endif } --non-interactive --redirect --agree-tos --nginx -d ${domain} -m ${email}

setsebool httpd_can_network_connect on -P

systemctl enable nginx.service
%{ endif }