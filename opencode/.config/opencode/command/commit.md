---
description: Commit the currently staged changes
subtask: false
model: opencode/gemini-3-flash
---

Check the currently staged files and commit them. If there are no staged changes do nothing and return.

Do not stage anything new.

Create an appropriate commit message

-   First line is a concise summary starting with a verb
-   Prefix first line with one of:
    -   `feat:` - new feature for the user
    -   `fix:` - bug fix
    -   `docs:` - documentation only changes
    -   `style:` - formatting, whitespace (no code change)
    -   `refactor:` - code change that neither fixes a bug nor adds a feature
    -   `perf:` - performance improvements
    -   `test:` - adding or correcting tests
    -   `build:` - build system or external dependencies
    -   `ci:` - CI configuration files and scripts
    -   `chore:` - other changes that don't modify src or test files
    -   `revert:` - reverts a previous commit
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

Here is optional additional context from the user:

$ARGUMENTS

