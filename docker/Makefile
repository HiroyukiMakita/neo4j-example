#########################################################
# imports
#########################################################

include .env
CONTAINER_EXEC_CYPHER_SHELL := ${CONTAINER_EXEC_CYPHER_SHELL}

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
	@$(EXEC)

exec-cypher:
	$(eval CONTAINER := $(GRAPH_DB))
	$(eval ARG := -c "bash $(CONTAINER_EXEC_CYPHER_SHELL)")
	@$(EXEC)

down:
	@$(DOWN)

remove:
	@$(DOWN) --rmi all --volumes --remove-orphans

destroy:
	@sudo rm -rf ./neo4j/logs ./neo4j/data ../dist && make remove