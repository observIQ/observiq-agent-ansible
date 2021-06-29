export PATH := ~/.local/bin:$(PATH)
export PY_COLORS := "1"
export ANSIBLE_FORCE_COLOR := "1"

.PHONY: install-tools
install-tools:
	pip install -r requirements.txt

.PHONY: test
test: install-tools create converge idempotence verify

.PHONY: clean
clean: destroy

.PHONY: create
create:
	molecule create

.PHONY: converge
converge:
	molecule converge

.PHONY: idempotence
idempotence:
	molecule idempotence

.PHONY: verify
verify:
	molecule verify

.PHONY: destroy
destroy:
	molecule destroy