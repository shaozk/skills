#!/usr/bin/env bash
# 把 skills/ 下的所有 skill 同步（拷贝）到本地工具目录。
# 用法：
#   ./scripts/sync.sh                  # 默认同步到 ~/.agents/skills
#   ./scripts/sync.sh ~/.claude/skills # 指定目标目录
#   ./scripts/sync.sh --dry-run        # 只打印将要同步的 skill，不实际拷贝
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$ROOT/skills"
TARGET="${HOME}/.agents/skills"
DRY_RUN=0

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    -h|--help)
      echo "用法: $0 [目标目录] [--dry-run]"
      echo "默认目标: ~/.agents/skills"
      exit 0
      ;;
    -*) echo "未知参数: $arg" >&2; exit 1 ;;
    *) TARGET="$arg" ;;
  esac
done

if [ "$DRY_RUN" -eq 1 ]; then
  echo "[dry-run] 目标目录: $TARGET"
fi

# 找出所有 skill 目录：skills/<分类>/<skill名>/SKILL.md
mapfile -t SKILL_FILES < <(find "$SKILLS_DIR" -mindepth 3 -maxdepth 3 -name SKILL.md ! -path "*/template/*" | sort)

if [ ${#SKILL_FILES[@]} -eq 0 ]; then
  echo "没有找到任何 skill（未考虑 template）。" >&2
  exit 1
fi

for f in "${SKILL_FILES[@]}"; do
  name="$(basename "$(dirname "$f")")"
  src="$(dirname "$f")"
  dest="$TARGET/$name"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "  $src -> $dest"
    continue
  fi
  mkdir -p "$TARGET"
  # 目标处可能是符号链接（旧的收集方式），先清掉再拷贝真实内容
  rm -rf "$dest"
  cp -R "$src" "$dest"
  echo "已同步: $name -> $dest"
done

echo "完成。"
