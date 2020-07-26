# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    hello.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mwane <mwane@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/12 11:24:59 by mwane             #+#    #+#              #
#    Updated: 2019/12/15 15:49:17 by mwane            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


apt-get install -y libnss3-tools
#ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
#nginx -t
service mysql start
echo "CREATE DATABASE testdb;" | mysql -u root
echo "CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT USAGE ON *.* TO 'testuser'@'localhost' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT ALL privileges ON testdb.* TO 'testuser'@localhost;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#ssl
mkdir ~/mkcert && \
  cd ~/mkcert && \
  wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
  mv mkcert-v1.1.2-linux-amd64 mkcert && \
  chmod +x mkcert
./mkcert -install
./mkcert localhost


service mysql restart
service php7.3-fpm restart
/etc/init.d/php7.3-fpm start
service nginx restart


#cat hello
bash
