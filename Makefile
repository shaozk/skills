.PHONY: help sync check

help: ## 列出所有可用目标
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-8s\033[0m %s\n", $$1, $$2}'

sync: ## 同步 skills 到本地工具目录（TARGET=~/.claude/skills 可指定目标）
	./scripts/sync.sh $(TARGET)

check: ## 校验所有 skill 符合仓库约定
	./scripts/validate.sh
