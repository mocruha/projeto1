#vars
POSTGRES_USER=postgres
POSTGRES_PASSWORD=senhasegura
POSTGRES_CONTAINER=db
DATABASE_NAME=my_game
POSTGRESQL_URL='postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@localhost:5432/$(DATABASE_NAME)?sslmode=disable'
MIGRATION_NAME=create_user_profile_table



.PHONY: init_migrate mig.up mig.down

init_migrate:
	migrate create -ext sql -dir ./sql/migrations -seq $(MIGRATION_NAME)	

mig.up:
	migrate -database ${POSTGRESQL_URL} -path ./sql/migrations up

mig.down:
	migrate -database ${POSTGRESQL_URL} -path ./sql/migrations down
