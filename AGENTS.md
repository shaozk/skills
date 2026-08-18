# AGENTS.md

本文件是给在本仓库工作的 AI agent 看的操作手册。结构约定、新增/收集 skill 的完整步骤、以及校验方式都在这里。仓库是**个人收藏夹**：不做 LICENSE、不用 CI，分类随收集自然增长。

## 仓库结构

```
skills/
├── <分类>/<skill-name>/   # 技能本体：SKILL.md 必须直接放在 skill 目录下
│   └── SKILL.md           # frontmatter 必须含 name（=目录名）和 description
├── INDEX.md               # 技能索引表：| 名称 | 分类 | 工具兼容性 | 来源 | 用途 |
└── template/              # 新增 skill 的骨架模板，禁止当作真实 skill
scripts/
├── sync.sh                # 拷贝 skills/*/* 到本地工具目录（默认 ~/.agents/skills）
└── validate.sh            # 校验所有 skill 符合约定
```

## 新增 / 收集一个 skill

1. **决定分类**：分类目录名用英文 slug（如 `interview`、`debugging`），不存在就新建；分类名不固定，随内容自然增长。
2. **复制模板起手**：`cp -R skills/template skills/<分类>/<skill-name>`，然后写 `SKILL.md`。
3. **收集来源时务必复制真实内容**：本仓库的约定是**完整复制入库**。如果来源是符号链接（本地 `~/.agents/skills/*` 可能是指向别处的软链），要用 `cp -RL` 解引用拷贝，绝不能把软链本身入库。
4. **frontmatter**：`name` 必须与目录名一致；`description` 用中文一句话说明用途，并带 trigger 短语（如 "Use when ..."）。
5. **登记索引**：在 `skills/INDEX.md` 的表格中新增一行。工具兼容性写 `agents` / `claude` / `both`；来源写 `自研` 或外部 URL。
6. **校验**：跑 `bash scripts/validate.sh`，通过后才算完成。

## 同步到本地工具目录

```bash
./scripts/sync.sh                  # 默认 ~/.agents/skills
./scripts/sync.sh ~/.claude/skills # 指定目标
```

脚本会 `rm -rf` 目标处的旧目录（含软链）再拷贝真实内容。

## 校验规则

`validate.sh` 检查每个 skill：SKILL.md 存在、frontmatter 含 name/description、name 与目录名一致、已登记进索引。

## 提交

用 jj 管理：`jj describe` 描述变更，`jj git push` 推到 origin。提交信息简洁说明改动（如 "add skill: xxx"）。
