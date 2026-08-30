---
name: pr-note
description: 基于当前分支上自己的提交（相对主分支，upstream 优先）生成 PR 标题与正文，套用项目 PR 模板与贡献规范。Use when 用户要开 PR、说 "pr-note"、或要求生成 PR 描述/PR 信息。
---

# Pr-Note：PR 信息生成

## 适用场景

- 把自己最近的一个或多个 commit 整理成一份可直接使用的 PR 标题 + 正文

## 步骤

1. **定基线**：与 commit skill 同一约定——有 `upstream` 远端用 upstream，否则用 `origin`；主分支在 `main` / `master` 中取实际存在的那个（`git remote`、`git rev-parse --verify <远端>/<分支>`），`git fetch <远端>` 后取 `git merge-base <基线> HEAD`。完成标准：基线远端、分支名、merge-base 三者明确。
2. **收集自己的提交**：`git config user.email` 取身份；`git log <merge-base>..HEAD --author=<邮箱>` 列出自己的提交（正文含 `Co-Authored-By: <邮箱>` 的也算），逐个读完整 message 与关键 diff，配合 `git diff <基线>...HEAD --stat` 看总览。完成标准：清单里每个提交都被读过，无遗漏；一条都没有时提示用户"基线之后没有你的提交"并停止。
3. **找项目 PR 要求**：按存在性检查 CONTRIBUTING.md（根目录 / `.github/` / `docs/`）、PR 模板（`.github/PULL_REQUEST_TEMPLATE.md` 或 `.github/PULL_REQUEST_TEMPLATE/`）、既有 PR/commit 风格（`git log --oneline -10`）。完成标准：存在的文件都读过；都不存在则记「项目无 PR 要求」。
4. **成文**：
   - 有模板：按模板字段逐项填写，填不了的写「不适用」或「待补」，保留模板原有标题结构
   - 无模板：默认五段——**标题**（一句话，动词开头，跟随仓库 commit 风格）、**动机**（为什么改）、**改动**（按提交归组列点）、**测试**（如何验证）、**风险**（回归点 / 需要 reviewer 留意处）
   - 完成标准：模板字段全覆盖或五段齐全；正文每条改动都能对应到一个真实提交（含哈希）。
5. **交付**：把标题 + 正文作为文本完整输出给用户；用户要求落盘时写到项目根 `PR_NOTE.md`。完成标准：用户可直接复制使用。

## 注意事项

- 语言跟随项目主导语言：PR 模板 / 贡献指南是英文就写英文，中文项目写中文。
- `PR_NOTE.md` 是生成物，加进 `.gitignore` 或提交前删掉。
- 只生成信息：不创建 PR、不 push（除非用户明确要求）。
