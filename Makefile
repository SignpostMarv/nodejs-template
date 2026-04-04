install:
	@npm install

build:
	@echo 'building from ./tsconfig.app.json'
	@./node_modules/.bin/tsc --project ./tsconfig.app.json

lint--tsc:
	@echo 'running syntax check'
	@./node_modules/.bin/tsc --project ./tsconfig.app-check.json

lint--prettier:
	@echo 'running prettier'
	@./node_modules/.bin/prettier . --check

lint--oxlint:
	@./node_modules/.bin/oxlint

lint: lint--prettier lint--tsc lint--oxlint

ci--basic-checks:
	./node_modules/.bin/tsc --project ./tsconfig.app-check.json
	./node_modules/.bin/prettier . --check
	./node_modules/.bin/oxlint

.PHONY: tests
tests: build
	@node ./tests.ts

.PHONY: coverage
coverage: build
	@./node_modules/.bin/c8 node ./tests.ts

npm-prep: tests
	@echo 'building from ./tsconfig.app-npm.json'
	@./node_modules/.bin/tsc --project ./tsconfig.app-npm.json
	@npm publish --dry-run
