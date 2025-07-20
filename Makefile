.PHONY: server-up

server-up:
	bin/rails s -e development

.PHONY: server-down

server-down:
	bin/rails s -e development
