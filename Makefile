default: test

COMPOSE_FILE = docker-compose.yml

export BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
export VCS_REF=$(strip $(shell git rev-parse --short HEAD))
export WEBAPP_VERSION=$(strip $(shell cat VERSION))

opac_version:
	@echo "Version file: " $(WEBAPP_VERSION)

vcs_ref:
	@echo "Latest commit: " $(VCS_REF)

build_date:
	@echo "Build date: " $(BUILD_DATE)

############################################
##			atalhos docker-compose		  ##
############################################

compose_build:
	@docker-compose -f $(COMPOSE_FILE) build

compose_up:
	@docker-compose -f $(COMPOSE_FILE) up -d

compose_stop:
	@docker-compose -f $(COMPOSE_FILE) stop

compose_ps:
	@docker-compose -f $(COMPOSE_FILE) ps

compose_rm:
	@docker-compose -f $(COMPOSE_FILE) rm -f

compose_exec_shell_webapp:
	@docker-compose -f $(COMPOSE_FILE) exec webapp bash
