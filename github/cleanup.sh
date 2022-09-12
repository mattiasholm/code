#!/usr/bin/env bash

set -e

owner='mattiasholm'
repo='gh'

runs=$(gh api "repos/$owner/$repo/actions/runs" --method GET --paginate --jq '.workflow_runs[].id')

for run in $runs; do
    gh api "repos/$owner/$repo/actions/runs/$run" --method DELETE
done
