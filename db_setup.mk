#vars
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhasegura
POSTGRES_CONTAINER=db
DATABASE_NAME=my_game
POSTGRESQL_URL='postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(DATABASE_NAME)?sslmode=disable'



.PHONY: db.up create_db db.down

db.all: db.up create_db
	@echo "Database setup complete."

db.up:
	docker compose up -d
	@echo "Docker up."
	@sleep 2

#create database. Input the path to the .sql file
CREATE_DB_PATH=./sql/creat/create_db.sql
create_db: 	
	docker compose exec -T $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -f $(CREATE_DB_PATH)
	@sleep 1

db.down:
	docker compose down
	rm -r ./sql/migrations
	@echo "Docker down."