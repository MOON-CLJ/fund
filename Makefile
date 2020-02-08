SHELL := /bin/bash
PATH  := /usr/local/bin:$(PATH)
APPENV_FILE := /data/webapps/appenv
PIP_INDEX_ARGS := --index-url https://pypi.tuna.tsinghua.edu.cn/simple

TARGET_PYTHON_INTERPRETER := python3
VIRTUALENV_CMD := virtualenv

VIRTUALENV_DIR := ./.venv

.PHONY: help
help:
	@echo "  venv           仅初始化后端 python 环境"
	@echo "  install        执行依赖安装"

.PHONY: venv
venv:
	$(VIRTUALENV_CMD) -p $(TARGET_PYTHON_INTERPRETER) --no-site-packages $(VIRTUALENV_DIR)

.PHONY: install
install:
	$(VIRTUALENV_DIR)/bin/pip install $(PIP_INDEX_ARGS) -U pip setuptools
	$(VIRTUALENV_DIR)/bin/pip install $(PIP_INDEX_ARGS) -r requirements.txt
	-test -f ./.pre-commit && { cp ./.pre-commit .git/hooks/pre-commit; chmod a+x .git/hooks/pre-commit; }
