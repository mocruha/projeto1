#vars
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhasegura
POSTGRES_CONTAINER=db
DATABASE_NAME=my_game
POSTGRESQL_URL='postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(DATABASE_NAME)?sslmode=disable'
MIGRATION_NAME=create_user_profile_table


.PHONY: up create_db db.down

all: db.up create_db
	@echo "Database setup complete."

db.up:
	docker compose up -d
	@sleep 2

create_db: 	
	docker compose exec -T $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -f ./sql/create/create_db.sql
	@sleep 1

db.down:
	docker compose down