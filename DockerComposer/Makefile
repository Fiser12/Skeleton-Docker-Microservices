DIR ?= App
ENV ?= dev
SERVICE ?= app-$(ENV)
IMAGE ?= symfony-app-$(ENV)

COMMAND ?= debug:container
.DEFAULT_GOAL := start
THIS_FILE := $(lastword $(MAKEFILE_LIST))

ENV_COMPOSER = dev
ENV_YARN = ""
ifeq ($(ENV),prod)
 ENV_COMPOSER = no-dev
 ENV_YARN = :prod
endif

#COMPOSER COMMANDS
composer-install:
	docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "composer install -d=/app/$(DIR) --$(ENV_COMPOSER)"

composer-update:
	@docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "composer update -d=/app/$(DIR) --$(ENV_COMPOSER)"

#SYMFONY COMMANDS
create-database:
	@docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "php /app/$(DIR)/etc/bin/symfony-console doctrine:database:create --if-not-exists"

migrations:
	@docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "php /app/$(DIR)/etc/bin/symfony-console do:mi:mi -v --no-interaction --allow-no-migration"

cache-clear:
	@docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "php /app/$(DIR)/etc/bin/symfony-console cache:clear -e $(ENV)"

symfony-console:
	@docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "php /app/$(DIR)/etc/bin/symfony-console $(COMMAND)"

#DOCKER COMMANDS
docker-compose-exec:
	@docker-compose -f docker-compose.$(ENV).yaml exec $(SERVICE) bash -c "$(COMMAND)"

stop:
	@docker-compose -f docker-compose.$(ENV).yaml down

start:
	@docker-compose -f docker-compose.$(ENV).yaml down && \
        	docker-compose -f docker-compose.$(ENV).yaml up -d

build:
	@docker-compose -f docker-compose.$(ENV).yaml down && \
        	docker-compose -f docker-compose.$(ENV).yaml build --pull && \
            docker-compose -f docker-compose.$(ENV).yaml up -d

composer-install-all:
	@docker-compose -f docker-compose.$(ENV).yaml exec app-$(ENV) bash -c "composer install -d=/app/App --$(ENV_COMPOSER)" && \
        docker-compose -f docker-compose.$(ENV).yaml exec app-$(ENV) bash -c "composer install -d=/app/App --$(ENV_COMPOSER)"

docker-connect:
	@docker exec -t -i $(IMAGE) /bin/bash