.PHONY: server-up

server-up:
	bin/rails s -e development

.PHONY: server-down

server-down:
	bin/rails s -e development

.PHONY: test

test:
	bundle exec rspec

.PHONY: db-migrate

db-migrate:
	bin/rails db:migrate

.PHONY: db-rollback

db-rollback:
	bin/rails db:rollback