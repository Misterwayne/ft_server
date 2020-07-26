

cd
cp /root/nginx-conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

service nginx start
service nginx status
bash