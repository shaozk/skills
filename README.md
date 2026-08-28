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

## 技能列表

| 名称 | 分类 | 用途 |
| --- | --- | --- |
| no-code | meta | 运行命令但不进行任何代码或文件改动，只返回文本结果 |
| commit | git | 自动暂存并提交代码，根据修改内容自动生成 commit message |
| co-auth | git | 提交时自动检测当前 agent，在 commit message 底部追加对应的 Co-Authored-By 署名 |

完整信息（工具兼容性、来源等）见 [`skills/INDEX.md`](./skills/INDEX.md)，新增 skill 时两处需同步更新。

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
