# skills

个人 AI Skill 收藏夹：集中收集、整理和自研 skill，多工具通用（OpenAI Agent Skills 格式，兼容 `~/.agents/skills`、`~/.claude/skills` 等）。

## 结构

```
skills/
├── <分类>/<skill-name>/   # 技能本体，分类自然增长
│   └── SKILL.md
├── INDEX.md               # 全部技能索引（名称/分类/工具/来源/用途）
└── template/              # 新增 skill 的骨架模板
scripts/
├── sync.sh                # 同步 skill 到本地工具目录
└── validate.sh            # 校验 skill 是否符合仓库约定
```

## 快速上手

```bash
# 查看有哪些 skill
cat skills/INDEX.md

# 同步到本地工具目录（默认 ~/.agents/skills）
./scripts/sync.sh
./scripts/sync.sh ~/.claude/skills
./scripts/sync.sh --dry-run

# 新增/收集 skill 后校验
./scripts/validate.sh
```

给 AI agent 的操作手册见 [`AGENTS.md`](./AGENTS.md)。
