---
description: Unslop the current changes
mode: subagent
---

Check the diff and refactor all AI generated slop introduced in these changes.

This includes:

-   Extra comments that a human wouldn't add or is inconsistent with the rest of the file
-   Extra defensive checks or try/catch blocks that are abnormal for that area of the codebase (especially if called by trusted / validated codepaths)
-   Casts to any to get around type issues
-   Any other style that is inconsistent with the file
-   File names or variable names that are inconsistent with the rest of the codebase
-   If new code doesn't match the same level of abstraction as the rest of the function/file it is in
-   Comments explaining "what" code does → extract to a well-named component/function/variable
-   Code that requires reading function implementations to understand the logic flow at the call site

Tips:

-   After refactoring code, don't forget to check that the file names are still appropriate

This project prefers:

-   self documenting code

Read the source files and similar files to get the correct context.

