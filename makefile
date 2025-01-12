#vars
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhasegura
POSTGRES_CONTAINER=db
DATABASE_NAME=my_game
POSTGRESQL_URL='postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(DATABASE_NAME)?sslmode=disable'
MIGRATION_NAME=create_user_profile_table

#db_setup has db.up, create_db db.down
include db_setup.mk
#migrate has init_migrate, mig.up, mig.down
include migrate.mk

.PHONY: 

all: init_migrate db.all



#insert data into the database
#add file path to the .sql file
INSERT_FILE_PATH=./sql/data/profiles.sql
fill_db:
	docker compose exec -T $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -d $(DATABASE_NAME) -f $(INSERT_FILE_PATH)

down: mig.down 	db.down 

