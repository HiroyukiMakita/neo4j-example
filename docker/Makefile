#########################################################
# imports
#########################################################

include .env

#########################################################
# variables
#########################################################

COMPOSE := docker-compose
BUILD := $(COMPOSE) build --no-cache
UP := $(COMPOSE) up -d
DOWN := $(COMPOSE) down
EXEC = $(COMPOSE) exec $(CONTAINER) bash $(ARG)
CONTAINER =
ARG =

# docker services (container name)
GRAPH_DB := neo4j

#########################################################
# if include source not exists commands
#########################################################

.env:
	@cp -n .env.example .env

#########################################################
# make commands
#########################################################

init:
	@make build up

build:
	@$(BUILD)

catch-up:
	$(eval CONTAINER := $(CENTOS))
	$(eval ARG := -c "cd $(CONTAINER_SOURCE_ROOT) && yarn install")
	@$(EXEC)

up:
	@$(UP)

exec-neo4j:
	$(eval CONTAINER := $(GRAPH_DB))
	$(eval CONTAINER_USER_NAME := root)
	$(eval CONTAINER_USER_NAME := root)
	@$(EXEC)

down:
	@$(DOWN)

remove:
	@$(DOWN) --rmi all --volumes --remove-orphans

destroy:
	@sudo rm -rf ./neo4j/logs ./neo4j/data ../dist && make remove