#!/usr/bin/env bash

set -e

owner='mattiasholm'
repo='gh'

if [[ -z $(gh repo view "$owner/$repo" 2>/dev/null) ]]; then
    gh repo create "$owner/$repo" --public
fi

gh repo edit "$owner/$repo" --description 'Repository created with GitHub CLI' --visibility 'private' --accept-visibility-change-consequences --enable-issues=false --enable-projects=false --enable-wiki=false
gh api "/repos/$owner/$repo" --method PATCH --silent --field has_downloads=false

if [[ $(gh api "/repos/$owner/$repo/contents/README.md" --method GET --jq .name 2>/dev/null) != 'README.md' ]]; then
    gh api "/repos/$owner/$repo/contents/README.md" --method PUT --silent \
        --field message="Initial commit" \
        --field content=$(echo -e "# $repo\nRepository created with GitHub CLI" | base64)
fi

if [[ $(gh api "/repos/$owner/$repo/contents/.gitignore" --method GET --jq .name 2>/dev/null) != '.gitignore' ]]; then
    gh api "/repos/$owner/$repo/contents/.gitignore" --method PUT --silent \
        --field message="Add .gitignore" \
        --field content=$(echo '.DS_Store' | base64)
fi

gh secret set 'SECRET' --body 'secret' --repo "$owner/$repo"

gh variable set 'VARIABLE' --body 'variable' --repo "$owner/$repo"

gh repo view "$owner/$repo" --json url
