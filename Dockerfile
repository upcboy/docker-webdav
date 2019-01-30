FROM httpd:alpine
RUN apk add --no-cache apache2-webdav apache2-utils openssl apache2-ssl       \
  && mkdir -p /storage/dav                                                    \
  && chmod -R 770 /storage                                                    \
  && chown -R root:www-data /storage                                          \
  && echo TransferLog /dev/stdout >> /etc/apache2/httpd.conf                  \
  && echo ErrorLog /dev/stderr  >> /etc/apache2/httpd.conf                    \
  && echo 'ServerName ${VIRTUAL_HOST}' >> /etc/apache2/httpd.conf             \
  && mkdir -p /run/apache2                                                    \
  && mkdir -p /var/lib/dav                                                    \
  && chown root:www-data /var/lib/dav                                         \
  && chmod 770 /var/lib/dav                                                   \
  && echo $'#!/bin/sh  \n\
htpasswd -cb /usr/user.passwd $USERNAME $PASSWORD     \n\
chown root:www-data /usr/user.passwd                  \n\
chmod 640 /usr/user.passwd                              \n\
\n\
/usr/sbin/httpd -d /etc/apache2 -f /etc/apache2/httpd.conf -DFOREGROUND -e info \n\
' > /run.sh                                                                   \
  && chmod 755 /run.sh
COPY dav.conf /etc/apache2/conf.d/0-dav.conf
COPY ssl.conf /etc/apache2/conf.d/ssl.conf
RUN openssl req -x509 -newkey rsa:2048 -days 1000 -nodes \
            -keyout /etc/ssl/apache2/server.key -out /etc/ssl/apache2/server.pem -subj "/CN=${webdav:-selfsig$

VOLUME ["/storage"]
EXPOSE 443

CMD ["/run.sh"]