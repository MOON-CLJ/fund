SHELL := /bin/bash
PATH  := /usr/local/bin:$(PATH)
APPENV_FILE := /data/webapps/appenv
PIP_INDEX_ARGS := --index-url https://pypi.tuna.tsinghua.edu.cn/simple --extra-index-url http://pypi.sankuai.com/simple --trusted-host pypi.sankuai.com

# 判断是否是IDC机器, 如果是的话, 使用对应的配置
TARGET_PYTHON_INTERPRETER := python3.6
VIRTUALENV_CMD := virtualenv

ifeq ($(APPENV_FILE), $(wildcard $(APPENV_FILE)))
	TARGET_PYTHON_INTERPRETER := /usr/local/python3.6.4/bin/python3.6
	VIRTUALENV_CMD := $(shell which virtualenv)
endif

VIRTUALENV_DIR := ./.venv
ifneq ($(MTDPDBA_VIRTUALENV_DIR),)
	VIRTUALENV_DIR := $(MTDPDBA_VIRTUALENV_DIR)
endif

.PHONY: help
help:
	@echo "  venv           仅初始化后端 python 环境"
	@echo "  install        执行依赖安装"

.PHONY: venv
venv:
# 由于PLUS构建阶段不能使用sudo, 所以没办法用pip安装virtualenv,
	$(VIRTUALENV_CMD) -p $(TARGET_PYTHON_INTERPRETER) --no-site-packages $(VIRTUALENV_DIR)

.PHONY: install
install:
	$(VIRTUALENV_DIR)/bin/pip install $(PIP_INDEX_ARGS) -U pip setuptools
	$(VIRTUALENV_DIR)/bin/pip install $(PIP_INDEX_ARGS) -r requirements.txt
	-test -f ./.pre-commit && { cp ./.pre-commit .git/hooks/pre-commit; chmod a+x .git/hooks/pre-commit; }