### Shell Commands in Devbox projects
If the current workspace has a `devbox.json`` file in its root directory that means it uses [Devbox](https://github.com/jetify-com/devbox). This means any terminal commands you run should be prefixed with `devbox run --pure` in order to work correctly.

### Bash and Tool calls
 - Bash commands: avoid chaining with `&&` — use separate Bash calls instead. Claude Code's compound-command security check ([#16561](https://github.com/anthropics/claude-code/issues/16561)) prompts even when each component is individually allowed.

### Code Comments

Code comments are acceptable, but:
- Keep comment length as short as possible while still conveying the desired information
- Do not reference how something **used** to work in a previous iteration or commit. e.g. Do **not say** things like "responds with a 401 instead of 404 when unauthorized" when changing the function to respond with 401. Instead, only reference the current implementation, e.g. "responds with 401 when unauthorized"

### Git & Github
- Use the `gh` CLI when possible.
- When creating a GitHub pull request, always mark it as a draft.
- After first creating a GitHub pull request, assign a relevant label for the category of change, such as `feature` or `bug`.
- *IMPORTANT*: When writing or revising a pull request title or body, invoke the `ruthless-pr-edit` skill. It owns the structure and the editorial standard.
- Do *not* add "🤖 Generated with Claude Code" to the pull request description.


