#!/usr/bin/env bash
php /app/Ecommerce/etc/bin/symfony-console doctrine:database:create --if-not-exists
php /app/Ecommerce/etc/bin/symfony-console do:mi:mi -v --no-interaction --allow-no-migration
openssl genrsa -out /app/Ecommerce/var/jwt/private.pem -aes256 -passout pass:${JWT_PASSPHRASE} 4096
openssl rsa -pubout -in /app/Ecommerce/var/jwt/private.pem -out /app/Ecommerce/var/jwt/public.pem -passin pass:${JWT_PASSPHRASE}

exec "$@"