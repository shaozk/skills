---
name: commit
description: 自动暂存并提交代码，根据修改内容自动生成 commit message。Use when 用户说"提交"/"commit"/"自动提交"，或想为当前改动快速生成一次提交。
---

# Commit

## 适用场景

- 用户想快速提交当前工作区的改动，不想手动写 commit message
- 用户说"帮我提交一下""自动 commit""提交这些改动"

## 步骤

1. 先了解改动内容：
   - `git status --short` 查看有哪些改动（含未跟踪文件）
   - `git diff` 查看未暂存改动；有暂存内容时再跑 `git diff --staged`
2. 提交前先把当前分支 rebase 到主分支最新：
   - 确定基线：有 `upstream` 远端（fork 场景）时用 `upstream`，否则用 `origin`；主分支在 `main` / `master` 中取实际存在的那个（`git remote` 查远端，`git rev-parse --verify <远端>/<分支>` 验分支）
   - `git fetch <远端>` 后执行 `git rebase <远端>/<主分支>`
   - 工作区有未提交改动时：先 `git stash` 暂存，rebase 完成后 `git stash pop` 检出暂存
   - rebase 出现冲突：停止流程向用户报告，stash 保留到 rebase 处理完再恢复；冲突解决前不暂存、不提交
3. 若存在未跟踪文件，确认是否应被提交：
   - 检查是否被 `.gitignore` 覆盖（`git check-ignore <file>`）
   - 排除密钥、构建产物、日志等不该入库的文件
4. 暂存改动：默认 `git add -A`；若用户指定了文件/目录，则只 `git add` 指定的路径。
5. 参考仓库既有提交风格（`git log --oneline -10`），根据 diff 内容生成 commit message：
   - 用 Conventional Commits 类型（`feat` / `fix` / `docs` / `refactor` / `test` / `chore` / `style` / `perf`），仓库风格不同则跟随仓库风格
   - 主题行简洁（≤ 50 字符）、动词开头、说明"做了什么"
   - 改动较多或跨多个方面时，用 `-m` 追加正文要点
6. 执行 `git commit -m "<message>"`（可加 `-m` 正文）。
7. 展示提交结果（`git log -1 --stat` 或 `git show --stat HEAD`）。
8. 默认只提交、不 push；用户要求 push 时再推。

## 注意事项

- 提交前先看 diff，绝不闭眼 `git add -A`：别把密钥、构建产物、临时文件一起提交。
- 存在未暂存 + 已暂存混合状态时，注意 `git commit` 只提交暂存区；如用户想提交全部，先统一 `git add`。
- 没有改动时提示用户"没有可提交的改动"，不要制造空提交。
- 只 commit 不 push（除非用户明确要求）。
