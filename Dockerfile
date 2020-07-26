# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mwane <mwane@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/12/12 11:24:40 by mwane             #+#    #+#              #
#    Updated: 2019/12/19 14:14:17 by mwane            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster


LABEL Malick Wane <mwane@student.42.fr>

COPY /src/hello.sh ./
COPY /src/config_nginx ./root/
RUN apt-get update -y && apt-get upgrade && apt-get install -y wget nginx mariadb-server mariadb-client 
RUN apt install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline \
php-mbstring

#NGINX
RUN mkdir -p  /var/www/html
COPY /src/index.html /var/www/html/
COPY /src/config_nginx /etc/nginx/sites-available/localhost
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
#RUN nginx -t

#MySQL
RUN service mysql start
RUN mysql --version
#newUser='testuser'
#newDbPassword='testpwd'
#newDb='testdb'
#host=localhost 
#commands="CREATE DATABASE \`testdb'\`;CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpw';GRANT USAGE ON *.* TO 'testuser'@'localhost' IDENTIFIED BY 'testpw';GRANT ALL privileges ON \`testdb`.*
#TO 'testuser'@'${host}';FLUSH PRIVILEGES;"
#RUN mysql
#RUN echo "CREATE DATABASE testdb;" | mysql -u root
#RUN CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpw';GRANT USAGE ON *.* TO 'testuser'@'localhost' IDENTIFIED BY 'testpw';GRANT ALL privileges ON `testdb`.*;TO 'testuser'@'${host}';FLUSH PRIVILEGES;" | mysql -u root

#WORDPRESS
#RUN cd /tmp
RUN mkdir -p /var/www/html/example
RUN wget https://wordpress.org/latest.tar.gz
#COPY /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
RUN tar -zxvf latest.tar.gz --strip-components=1 -C /var/www/html/example
RUN chown -R www-data:www-data /var/www/html/example
#RUN curl -s https://api.wordpress.org/secret-key/1.1/salt/
COPY src/wp-config.php /var/www/html/example/wp-config.php

#PHP
RUN service php7.3-fpm start
#RUN mysql -u root
#RUN php --version
RUN mkdir -p var/www/html/phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
COPY src/config.inc.php var/www/html/phpmyadmin/
#COPY phpMyAdmin-4.9.0.1-all-languages/  var/www/phpmyadmin/

#SSL

COPY /src/info.php /var/www/html/
COPY src/self-signed.conf /etc/nginx/snippets/
COPY src/ssl-params.conf /etc/nginx/snippets/
COPY src/nginx-selfsigned.crt /etc/ssl/certs/
COPY src/nginx-selfsigned.key /etc/ssl/private/
COPY src/dhparam.pem /etc/nginx/
EXPOSE 80 80
EXPOSE 433 433
CMD bash hello.sh 