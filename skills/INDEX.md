# SKILL 索引

> 分类随收集自然增长，新增 skill 时同步登记到此处。

## 使用说明

- **工具兼容性**：`agents`（OpenAI Agent Skills，~/.agents/skills）、`claude`（~/.claude/skills）、`both`（通用）
- **来源**：`自研` 或外部 URL
- **同步**：`scripts/sync.sh` 会把 skill 拷贝到本地工具目录

## 索引

| 名称 | 分类 | 工具兼容性 | 来源 | 用途 |
| --- | --- | --- | --- | --- |
| no-code | meta | both | 自研 | 运行命令但不进行任何代码或文件改动，只返回文本结果 |
| commit | git | both | 自研 | 自动暂存并提交代码，根据修改内容自动生成 commit message |
| co-auth | git | both | 自研 | 提交时自动检测当前 agent，在 commit message 底部追加对应的 Co-Authored-By 署名 |
| trans | translation | both | 自研 | 把英文 Markdown 文档翻译成中文，保留格式与代码块 |
