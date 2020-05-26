FROM php:7.4-fpm

RUN apt-get update

RUN apt-get install -y git-core curl build-essential openssl libssl-dev python python3 \
 && git clone https://github.com/nodejs/node.git \
 && cd node \
 && ./configure \
 && make \
 && sudo make install

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN chmod 755 /usr/src/app/startup.sh

ENTRYPOINT [ "sh", "/usr/src/app/startup.sh" ]