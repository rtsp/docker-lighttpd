.PHONY: reset down up build

reset: down build up
	docker ps

down:
	docker-compose -f docker-compose.yml down

up:
	docker-compose -f docker-compose.yml up -d --no-build

build:
	docker-compose -f docker-compose.yml build --no-cache
