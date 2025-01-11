#vars
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhasegura
POSTGRES_CONTAINER=db
DATABASE_NAME=my_game
POSTGRESQL_URL='postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(DATABASE_NAME)?sslmode=disable'



.PHONY: up init profile_table add_table  profile_down down

all: up create_db
	@echo "Database setup complete."

up:
	docker compose up -d
	@sleep 2

create_db: 	
	docker compose exec -T $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -f ./sql/create/create_db.sql
	@sleep 1

init_migrate:
	migrate create -ext sql -dir ./sql/migrations -seq create_user_profile_table	

add_profile_table:
	migrate -database ${POSTGRESQL_URL} -path ./sql/migrations up

profile_down:
	migrate -database ${POSTGRESQL_URL} -path ./sql/migrations down

down:
	docker compose down
	