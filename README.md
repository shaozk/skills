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
Makefile                   # 常用入口：make help / sync / check
```

## 技能列表

| 名称 | 分类 | 用途 |
| --- | --- | --- |
| no-code | meta | 运行命令但不进行任何代码或文件改动，只返回文本结果 |
| commit | git | 提交前自动 rebase 主分支（upstream 优先，冲突即停），暂存并生成 commit message |
| co-auth | git | 提交时自动检测当前 agent，在 commit message 底部追加对应的 Co-Authored-By 署名 |
| pr-note | git | 基于自己相对主分支的提交生成 PR 标题与正文，套用项目 PR 模板与规范 |
| trans | translation | 把英文 Markdown 文档翻译成中文，保留格式与代码块 |
| read | learning | 通读项目并生成七段式中文学习文档 READ.md |
| update-readme | docs | 根据提交信息与代码现状更新 README.md，没有则创建 |

完整信息（工具兼容性、来源等）见 [`skills/INDEX.md`](./skills/INDEX.md)，新增 skill 时两处需同步更新。

## 快速上手

```bash
# 查看有哪些 skill
cat skills/INDEX.md

# 同步到本地工具目录（默认 ~/.agents/skills）
make sync
make sync TARGET=~/.claude/skills
./scripts/sync.sh --dry-run

# 新增/收集 skill 后校验
make check
```

给 AI agent 的操作手册见 [`AGENTS.md`](./AGENTS.md)。
