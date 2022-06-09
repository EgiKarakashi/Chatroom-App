# HASURA SEED SOURCE
# it is used in the
seed?=seed

# HASURA MIGRATION STEPS
# it is used in the hasura postgres migration scripts to control
# how many up/down migrations to applu
steps?=1



#
# Project Management
#

start:
	@echo "Starting the project..."
	@docker-compose up -d
	@docker-compose logs -f

stop:
	@echo "Stopping the project..."
	@docker-compose down

logs:
	@docker-compose logs -f

clear: stop
	@echo "Destroy local data..."
	@sudo rm -rf .docker-data

restart: stop start
reset: stop clear start



#
# Hasura State Management
#

init:
	@echo "Applying migrations to all databases..."
	@hasura migrate apply --project hasura-chatrooms --all-databases
	@echo "Applying Hasura metadata..."
	@hasura metadata apply --project hasura-chatrooms
	@echo "Seeding the main database from: \"$(seed).sql\"..."
	@hasura seed apply --project hasura-chatrooms --database-name default --file $(seed).sql

seed:

	@echo "Seeding the main database from: \"$(seed).sql\"..."
	@hasura seed apply --project hasura-chatrooms --database-name default --file $(seed).sql


#
# PostgreSQL Migration Utilities
#

init-metadata:
	@hasura metadata apply --project hasura-chatrooms

migrate:
	@hasura migrate apply --project hasura-chatrooms --database-name default
	
migrate-status:
	@hasura migrate status --project hasura-chatrooms --database-name default


migrate-up:
	@hasura migrate apply --project hasura-chatrooms --database-name default --up $(steps)

migrate-down:
	@hasura migrate apply --project hasura-chatrooms --database-name default --down $(steps)

migrate-redo:
	@hasura migrate apply --project hasura-chatrooms --database-name default --down $(steps)
	@hasura migrate apply --project hasura-chatrooms --database-name default --up $(steps)

migrate-users:
	@hasura migrate apply --version "1654686418798" --database-name default --project hasura-chatrooms 

migrate-chatrooms:
	@hasura migrate apply --version "1654686439412" --database-name default --project hasura-chatrooms 

migrate-messages:
	@hasura migrate apply --version "1654708762287" --database-name default --project hasura-chatrooms 

migrate-create:
	@hasura migrate create \
		"$(name)" \
		--up-sql "SELECT NOW();" \
		--down-sql "SELECT NOW();" \
		--database-name default \
		--project hasura-chatrooms
	@hasura migrate apply --project hasura-chatrooms --database-name default


adding-new-table:
	@hasura migrate create \
  "full-schema" \
  --from-server \
  --database-name default \
  --project hasura-chatrooms
  