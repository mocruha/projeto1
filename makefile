include db_setup.mk
include migrate.mk

.PHONY: 

all: db_setup migrate
	@echo "Database setup complete."

db.up: db.up
	@echo "Docker up."

db_down: db.down
	@echo "Docker down."

mig.up: mig.up
	@echo "Migration up."

mig.down: mig.down
	@echo "Migration down."