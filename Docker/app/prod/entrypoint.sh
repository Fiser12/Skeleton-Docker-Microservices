sed \
        -e "s/\${APP_ENV}/${APP_ENV}/" \
        /app/App/.env-docker.dist  > /app/App/.env
exec "$@"