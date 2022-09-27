
.default: help

help:
	@echo "usage:"

PLATFORM := ${shell uname -o}
PROJECT_NAME := text_manipulations

ifeq (${VIRTUAL_ENV},)
  INVENV = pdm run
else
  INVENV = 
endif

${info Platform: ${PLATFORM}}

dev: install-dev
install-dev:
	pdm install

.PHONY: test
test:
	${INVENV} pytest -vv tests

.PHONY: run-tests-w-coverage
run-tests-w-coverage:
	${INVENV} pytest -vv --cov=${PROJECT_NAME}  --cov-report=xml tests

.PHONY: type-check
type-check:
	${INVENV} mypy ${PROJECT_NAME} tests

.PHONY: lint
lint:
	${INVENV} pylint --rcfile=pylintrc ${PROJECT_NAME} tests

.PHONY: fmt
fmt:
	${INVENV} black ${PROJECT_NAME} tests

.PHONY: check-fmt
check-fmt:
	${INVENV} black --check ${PROJECT_NAME} tests
