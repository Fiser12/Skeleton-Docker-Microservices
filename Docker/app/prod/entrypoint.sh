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
        /app/App/env-parameters.yml  > /app/App/parameters.yml
exec "$@"