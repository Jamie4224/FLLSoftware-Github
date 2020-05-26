FROM php:7.4-cli

RUN apt-get update

RUN apt-get install git-core curl build-essential openssl libssl-dev \
 && git clone https://github.com/nodejs/node.git \
 && cd node \
 && ./configure \
 && make \
 && sudo make install

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN git clone -b docker https://<token>:x-oauth-basic@github.com/Jamie4224/FLLSoftware.git /repo/
RUN cp -R /repo/* /usr/src/app/repository/

RUN cp /config/.env /usr/src/app/repository/web


RUN chown app:app -R /usr/src/app/repository/

WORKDIR /usr/src/app/repository/web

RUN composer install --optimize-autoloader --no-dev

RUN npm install
RUN npm run production

RUN php artisan config:cache

RUN chmod 755 /usr/src/app/startup.sh

ENTRYPOINT [ "sh", "/usr/src/app/startup.sh" ]