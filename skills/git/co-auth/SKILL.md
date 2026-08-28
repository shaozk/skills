---
name: co-auth
description: 代码提交时自动检测当前运行的 agent，在 commit message 底部追加对应的 Co-Authored-By 署名。Use when 用户说"加 co-auth"/"署名提交"/"commit 带上 agent 署名"，或使用 commit skill 提交时需要标注 agent。
---

# Co-Auth

## 适用场景

- 用户要求提交时标注当前 agent（Co-Authored-By）
- 与 commit skill 搭配：生成 commit message 后，按本 skill 追加署名行再提交

## Agent 识别表

> 后续新增 agent 时，在此表加一行即可，其余步骤不用改。

| Agent | 识别方式（按顺序检测） | Co-Authored-By 行 |
| --- | --- | --- |
| opencode | 环境变量 `OPENCODE` 存在（通常为 `1`） | `Co-Authored-By: opencode-agent[bot] <opencode-agent[bot]@users.noreply.github.com>` |
| claudecode | 环境变量 `CLAUDECODE` 存在（通常为 `1`），兜底 `CLAUDE_CODE_ENTRYPOINT` | `Co-Authored-By: Claude <noreply@anthropic.com>` |
| （预留位） | 识别方式待补充 | 署名行待补充 |

## 步骤

1. 按「Agent 识别表」自上而下检测当前环境（读环境变量），确定当前 agent。
2. 所有条目都不匹配时，不加署名，或向用户确认，不要靠猜。
3. 生成 commit message 后，把署名行作为 git trailer 追加到 message 最底部，与正文之间空一行：

   ```
   feat: add xxx

   - point one

   Co-Authored-By: opencode-agent[bot] <opencode-agent[bot]@users.noreply.github.com>
   ```

4. 多个 agent 匹配时，每个 agent 一行，依次列出。
5. 执行提交，例如：

   ```bash
   git commit -m "feat: add xxx" -m "Co-Authored-By: opencode-agent[bot] <opencode-agent[bot]@users.noreply.github.com>"
   ```

   第二个 `-m` 会自动与前文空一行，成为 trailer。

## 注意事项

- 署名行必须与正文之间空一行，git 才能把它识别为 Co-Authored-By trailer（`git log --format="%%(trailers)"` 可验证）。
- 仓库已有其他署名风格（`git log` 可见）时，跟随仓库既有风格。
- 只在本次提交时追加署名；不要改写历史提交，除非用户明确要求。
- 新增 agent 只需扩充「Agent 识别表」，不要改动步骤。
