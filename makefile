#vars
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhasegura
POSTGRES_CONTAINER=db
DATABASE_NAME=my_game
POSTGRESQL_URL='postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(DATABASE_NAME)?sslmode=disable'


# Database setup
.PHONY: db.up create_db db.down

db.all: db.up create_db
	@echo "Database setup complete."

db.up:
	docker compose up -d
	@echo "Docker up."
	@sleep 2

#create database. Input the path to the .sql file
CREATE_DB_PATH=./sql/create/create_db.sql
create_db: 	
	docker compose exec -T $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -f $(CREATE_DB_PATH)
	@sleep 1

db.down:
	docker compose down
	rm -r ./sql/migrations
	@echo "Docker down."

########################################
# Fill database

.PHONY: fill_db down

all: init_migrate db.all

#insert data into the database
#add file path to the .sql file
INSERT_FILE_PATH=./sql/data/user_game_data.sql
fill_db:
	docker compose exec -T $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -d $(DATABASE_NAME) -f $(INSERT_FILE_PATH)

down: mig.down 	db.down 


########################################
# Migration

.PHONY: init_migrate mig.up mig.down

mig.all: init_migrate mig.up
	@echo "Migration complete."

#name migration commit
MIGRATION_NAME=create_ban_profile_game_tables
init_migrate:
	migrate create -ext sql -dir ./sql/migrations -seq $(MIGRATION_NAME)
	sleep 1

mig.up:
	migrate -database ${POSTGRESQL_URL} -path ./sql/migrations up

mig.down:
	migrate -database ${POSTGRESQL_URL} -path ./sql/migrations down

