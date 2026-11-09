---
name: write-weekly-report
description: Query GitHub activity for KMiri and Asterinas, summarize zjp-CN's weekly work and lwz23's PRs, and format a Chinese weekly report. Use when asked to prepare or publish a KMiri weekly report.
---

# Write Weekly Report

Prepare a Chinese weekly report from GitHub activity in the `KMiri-rs` and `asterinas` organizations. Match the style of [discussion #313](https://github.com/orgs/KMiri-rs/discussions/313) and the latest formatting preferences recorded in [discussion #320](https://github.com/orgs/KMiri-rs/discussions/320).

## Determine the reporting window

- Use the exact start and end timestamps supplied by the user.
- If the user gives only a week, use the Sunday-to-Sunday reporting window in `Asia/Shanghai`, ending at 23:59:00 +08:00. State the full range in the report.
- Search with the requested user (`zjp-CN` by default), the two org qualifiers `org:KMiri-rs org:asterinas`, and the requested period.

## Gather GitHub data

Use `gh api` against GitHub Search API and inspect all results. URL-encode spaces, colons, and plus signs in the query; a full encoded API URL works when `gh search issues` cannot parse the author/date query.

Collect:

1. `author:zjp-CN created:<range> org:KMiri-rs org:asterinas type:pr`
2. `author:zjp-CN created:<range> org:KMiri-rs org:asterinas type:issue`
3. `author:zjp-CN closed:<range> org:KMiri-rs org:asterinas type:pr`
4. `author:zjp-CN closed:<range> org:KMiri-rs org:asterinas type:issue`
5. `author:lwz23 created:<range> org:KMiri-rs type:pr` for the “审查 PR” section.

Request up to 100 results per page and paginate if needed. For each relevant PR, inspect its title, body, state, merged status, and additions/deletions with `gh api repos/OWNER/REPO/pulls/NUMBER`. Inspect linked issues or discussions when their context affects the summary. Distinguish open, closed, and merged status; do not describe a PR as merged unless `merged_at` confirms it. Summarize lwz23's matching PRs as items to review; do not imply a formal review was submitted unless the review data confirms it.

## Write the report

Use a Chinese title in the form `【第 N 周】...`, followed by `# 总结`, topical subsections, `# 审查 PR`, and `# 统计`. Common topics from recent reports include IRQ support, Redox, design-document updates, and maintenance; choose headings that match the actual activity.

- Keep the prose concise and group related PRs/issues under one bullet.
- For a GitHub PR, issue, or discussion that supports a summary bullet, put its **bare URL on its own nested bullet**. For example:

  ```markdown
  * 更新 Redox CI 测试并处理资源耗尽问题。
    * https://github.com/KMiri-rs/KMiri/pull/315
    * https://github.com/KMiri-rs/KMiri/issues/304
  ```

- Put GitHub Search query links inline in the sentence or count, using descriptive Markdown text such as `[13 个 PR](SEARCH_URL)`. Do not put query URLs on their own bullet lines.
- In `# 审查 PR`, put the sentence about lwz23's weekly PR count in a paragraph, not a bullet. Link the count inline, e.g. `lwz23 本周在 KMiri-rs 组织新提交了 [4 个 PR](SEARCH_URL)，查询结果中均为开放状态。` Then use summary bullets with nested bare GitHub PR/issue/discussion URLs.
- In `# 统计`, include bullets for authored PRs/issues created, PRs/issues closed, and lwz23's PR count for review. Link each number inline to its corresponding Search query.
- Put PR line counts in a `<details>` block whose summary is `zjp-CN 的 PR 行数情况（按提交时间由新到旧）`. Keep the content as a Markdown table with repo, PR number, title, additions, and deletions, followed by totals.
- Make table PR numbers reference links. Use unique labels such as `[319][kmiri-319]` and define each label to its PR URL below the table inside the details block. Sort rows by PR creation time, newest first. Sum additions and deletions from the API results.
- Do not add a “协作” section. Include meeting or offline work only when the user provides that information.

## Publish only when requested

Drafting the report does not imply permission to post it. Publish only when the user explicitly asks to submit or publish the report.

Before posting, check the discussions list for an existing report for the same week to avoid duplicates. Use the `Announcements` category used by discussion #313. Retrieve the repository ID and category ID with GraphQL, then create the discussion with `createDiscussion`; the REST create endpoint returned 404 in the tested environment. After creation, read the discussion back and verify its title, body, category, links, table, and report counts. For edits to an existing discussion, use GraphQL `updateDiscussion` and verify the updated body.
