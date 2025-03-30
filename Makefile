.PHONY: install-tools
install-tools:
	brew install llvm
	cargo install cargo-watch
	cargo install cargo-audit
	cargo install cargo-udeps
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

.PHONY: clean
clean:
	cargo clean
	rm -rf target

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
	./scripts/init_redis.sh

.PHONY: udeps
udeps:
	cargo +nightly udeps
