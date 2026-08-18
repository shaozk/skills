#!/usr/bin/env bash
# 校验 skills/ 下所有 skill 是否符合仓库约定：
#   1. 每个 skill 目录必须有 SKILL.md
#   2. SKILL.md 的 frontmatter 必须包含 name 和 description
#   3. name 必须与目录名一致
#   4. skill 必须已登记在 skills/INDEX.md 的索引表中
# 用法：./scripts/validate.sh
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$ROOT/skills"
INDEX="$SKILLS_DIR/INDEX.md"
FAILED=0

mapfile -t SKILL_FILES < <(find "$SKILLS_DIR" -mindepth 3 -maxdepth 3 -name SKILL.md ! -path "*/template/*" | sort)

fail() {
  echo "  [FAIL] $1" >&2
  FAILED=1
}

if [ ! -f "$INDEX" ]; then
  echo "[FAIL] 缺少索引文件: $INDEX" >&2
  exit 1
fi

echo "校验 $SKILLS_DIR 下的 skill（共 ${#SKILL_FILES[@]} 个）："

for f in "${SKILL_FILES[@]}"; do
  dir="$(dirname "$f")"
  name="$(basename "$dir")"
  ok=1

  # 1. SKILL.md 存在（已由 find 保证），检查 frontmatter 完整性
  if ! head -1 "$f" | grep -q '^---$'; then
    echo "  [FAIL] $name: SKILL.md 必须以 --- 开头（frontmatter）" >&2
    ok=0
  fi

  fm_name="$(awk '/^---$/{n++} n==1 && /^name:/{sub(/^name:[[:space:]]*/, ""); print; exit}' "$f")"
  fm_desc="$(awk '/^---$/{n++} n==1 && /^description:/{sub(/^description:[[:space:]]*/, ""); print; exit}' "$f")"

  if [ -z "$fm_name" ]; then
    echo "  [FAIL] $name: frontmatter 缺少 name" >&2
    ok=0
  elif [ "$fm_name" != "$name" ]; then
    echo "  [FAIL] $name: frontmatter 的 name 为 '$fm_name'，与目录名不一致" >&2
    ok=0
  fi

  if [ -z "$fm_desc" ]; then
    echo "  [FAIL] $name: frontmatter 缺少 description" >&2
    ok=0
  fi

  # 4. 已登记进索引
  if ! grep -q "| $name |" "$INDEX"; then
    echo "  [FAIL] $name: 未登记在 $INDEX（应有一行 | $name | ...）" >&2
    ok=0
  fi

  if [ "$ok" -eq 1 ]; then
    echo "  [ok] $name"
  else
    FAILED=1
  fi
done

if [ "$FAILED" -eq 0 ]; then
  echo "全部通过。"
else
  echo "存在失败项。" >&2
  exit 1
fi
