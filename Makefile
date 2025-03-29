.PHONY: install-tools
install-tools:
	cargo install cargo-watch
	cargo install cargo-audit
	cargo install --version="~0.7" sqlx-cli --no-default-features --features rustls,postgres
	rustup component add clippy
	rustup component add rustfmt

.PHONY: watch
watch:
	cargo watch -x run

.PHONY: test
test:
	cargo test

.PHONY: check
check:
	cargo check

.PHONY: build
build:
	cargo build

.PHONY: run
run:
	cargo run

.PHONY: clippy
clippy:
	cargo clippy -- -D warnings

.PHONY: fmt
fmt:
	cargo fmt

.PHONY: audit
audit:
	cargo audit

.PHONY: db-up
db-up:
	./scripts/init_db.sh

.PHONY: migrate
migrate:
	@echo "Running database migrations..."
	$(eval DB_USER := postgres)
	$(eval DB_PASSWORD := password)
	$(eval DB_NAME := newsletter)
	$(eval DB_PORT := 15432)
	$(eval DB_HOST := localhost)
	$(eval DATABASE_URL := postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME))
	DATABASE_URL="$(DATABASE_URL)" sqlx database create
	DATABASE_URL="$(DATABASE_URL)" sqlx migrate run
	@echo "Migrations completed successfully!"

