FROM debian:9.9-slim

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y \
    wget \
    curl \
    dialog \
    bsdutils \
    make \
    nano \
    g++ \
    git \
    supervisor

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

RUN echo "deb http://nginx.org/packages/debian/ stretch nginx" > /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/debian/ stretch nginx" >> /etc/apt/sources.list.d/nginx.list
RUN cd /tmp && wget http://nginx.org/keys/nginx_signing.key && apt-key add nginx_signing.key

RUN apt-get update
RUN apt-get install -y nginx nodejs

RUN npm install -g node-gyp gulp

#
# Remove the packages that are no longer required after the package has been installed
RUN DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -q -y
RUN DEBIAN_FRONTEND=noninteractive apt-get autoclean -y -q
RUN DEBIAN_FRONTEND=noninteractive apt-get clean -y

# Remove all non-required information from the system to have the smallest
# image size as possible
# ftp://cgm_gebraucht%40used-forklifts.org:bZAo6dH1cyxhJpgJwO@ftp.strato.com/
RUN rm -rf /usr/share/doc/* /usr/share/man/?? /usr/share/man/??_* /usr/share/locale/* /var/cache/debconf/*-old /var/lib/apt/lists/* /tmp/*

