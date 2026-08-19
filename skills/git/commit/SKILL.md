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
2. 若存在未跟踪文件，确认是否应被提交：
   - 检查是否被 `.gitignore` 覆盖（`git check-ignore <file>`）
   - 排除密钥、构建产物、日志等不该入库的文件
3. 暂存改动：默认 `git add -A`；若用户指定了文件/目录，则只 `git add` 指定的路径。
4. 参考仓库既有提交风格（`git log --oneline -10`），根据 diff 内容生成 commit message：
   - 用 Conventional Commits 类型（`feat` / `fix` / `docs` / `refactor` / `test` / `chore` / `style` / `perf`），仓库风格不同则跟随仓库风格
   - 主题行简洁（≤ 50 字符）、动词开头、说明"做了什么"
   - 改动较多或跨多个方面时，用 `-m` 追加正文要点
5. 执行 `git commit -m "<message>"`（可加 `-m` 正文）。
6. 展示提交结果（`git log -1 --stat` 或 `git show --stat HEAD`）。
7. 默认只提交、不 push；用户要求 push 时再推。

## 注意事项

- 提交前先看 diff，绝不闭眼 `git add -A`：别把密钥、构建产物、临时文件一起提交。
- 存在未暂存 + 已暂存混合状态时，注意 `git commit` 只提交暂存区；如用户想提交全部，先统一 `git add`。
- 没有改动时提示用户"没有可提交的改动"，不要制造空提交。
- 只 commit 不 push（除非用户明确要求）。
