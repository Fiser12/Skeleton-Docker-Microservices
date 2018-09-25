FROM php:7.1-fpm

RUN apt-get update \
	&& apt-get install -y \
		zip \
		unzip \
		vim \
		wget \
		curl \
		git \
		mysql-client \
		moreutils \
		dnsutils \
		zlib1g-dev \
		libicu-dev \
		libmemcached-dev \
		g++ \
&& rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Set your timezone here
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime
RUN "date"

# Run docker-php-ext-install for available extensions
RUN docker-php-ext-configure intl \
&& docker-php-ext-install pdo pdo_mysql opcache intl
ADD . /app

RUN chmod -R 777 /app

RUN composer install -d /app/Files --no-dev --no-interaction
RUN composer install -d /app/App --no-dev --no-interaction

CMD sed \
        -e "s/\${database_host}/${DB_HOST}/" \
        -e "s/\${database_port}/${DB_PORT}/" \
        -e "s/\${database_name}/${DB_DATABASE}/" \
        -e "s/\${database_user}/${DB_ROOT}/" \
        -e "s/\${database_password}/${MYSQL_ROOT_PASSWORD}/" \
        -e "s/\${database_server_version}/${MYSQL_DATABASE_SERVER_VERSION}/" \
        -e "s/\${mailer_transport}/${MAILER_TRANSPORT}/" \
        -e "s/\${mailer_host}/${MAILER_HOST}/" \
        -e "s/\${mailer_user}/${MAILER_USER}/" \
        -e "s/\${mailer_password}/${MAILER_PASSWORD}/" \
        -e "s/\${mail_delivery_address}/${MAILER_DELIVERY_ADDRESS}/" \
        -e "s/\${router_request_context_host}/${REQUEST_CONTEXT_HOST}/" \
        -e "s/\${router_request_context_scheme}/${REQUEST_CONTEXT_SCHEME}/" \
        -e "s/\${secret-app}/${SECRET_KEY_APP}/" \
        -e "s/\${secret-compositeui}/${SECRET_KEY_COMPOSITE_UI}/" \
        -e "s/\${env}/prod/" \
        /app/Docker/php/app-parameters.yml.dist > /app/App/parameters.yml  && \
    sed \
        -e "s/\${database_host}/${DB_HOST}/" \
        -e "s/\${database_port}/${DB_PORT}/" \
        -e "s/\${database_name}/${DB_DATABASE}/" \
        -e "s/\${database_user}/${DB_ROOT}/" \
        -e "s/\${database_password}/${MYSQL_ROOT_PASSWORD}/" \
        -e "s/\${database_server_version}/${MYSQL_DATABASE_SERVER_VERSION}/" \
        -e "s/\${mailer_transport}/${MAILER_TRANSPORT}/" \
        -e "s/\${mailer_host}/${MAILER_HOST}/" \
        -e "s/\${mailer_user}/${MAILER_USER}/" \
        -e "s/\${mailer_password}/${MAILER_PASSWORD}/" \
        -e "s/\${mail_delivery_address}/${MAILER_DELIVERY_ADDRESS}/" \
        -e "s/\${router_request_context_host}/${REQUEST_CONTEXT_HOST}/" \
        -e "s/\${router_request_context_scheme}/${REQUEST_CONTEXT_SCHEME}/" \
        -e "s/\${secret-app}/${SECRET_KEY_APP}/" \
        -e "s/\${secret-compositeui}/${SECRET_KEY_COMPOSITE_UI}/" \
        -e "s/\${env}/prod/" \
        /app/Docker/php/files-parameters.yml.dist > /app/Files/parameters.yml  && \
        php /app/App/etc/bin/symfony-console doctrine:database:create --if-not-exists && \
        php /app/App/etc/bin/symfony-console do:mi:mi -v --no-interaction --allow-no-migration && \
        php /app/Files/etc/bin/symfony-console doctrine:database:create --if-not-exists && \
        php /app/Files/etc/bin/symfony-console do:mi:mi -v --no-interaction --allow-no-migration && \
        (cd /app/CompositeUi && yarn install) && \
        (cd /app/CompositeUi && yarn build) && \
        php-fpm -F