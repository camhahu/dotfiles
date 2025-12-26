---
description: Commit the currently staged changes
subtask: false
model: opencode/glm-4.6
---

Check the currently staged files and commit them. If there are no staged changes do nothing and return.

Do not stage anything new.

Create an appropriate commit message

-   First line is a concise summary starting with a verb
-   Prefix first line with "feat:", "bugfix:", "chore:", "docs:", "refactor:", or similar
-   Followed by a blank line
-   Then minimum of 1 and maximum of 4 dotpoints further explaining the change
    -   Prefer to explain WHY something was done from an end user perspective instead of WHAT was done
    -   Do not include generic messages like "improved agent experience" be very specific about what user facing changes were made
    -   Do not state obvious things
-   Avoid adjectives

Here is the current git status (from `git status`):
!`git status`

Here are recent commit messages (from `git log --oneline -10`):
!`git log --oneline -10`

