# Upgrade from Vaultwarden upstream

```sh
# Ensure you are on the deploy branch and have upstream remote set
git fetch upstream
git pull upstream <tag> # Replace <tag> with the desired version tag, e.g., v1.27.0. Branch can be used instead of tag but it is not recommended.
# Update "post_build_hook.sh" with the latest version of web_vault if needed
# Resolve any conflicts that arise, like deleted files on our side in .github/workflows
git add --all
git commit -sm "chore(update): <tag>" # Replace <tag> with chosen tag
git push origin deploy
```