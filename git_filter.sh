#!/usr/bin/env bash

git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch $1" \
  --prune-empty --tag-name-filter cat -- --all

for ref in $(git for-each-ref --format='%(refname)' refs/original); do 
    git update-ref -d $ref; 
done
git reflog expire --expire=now --all
git gc --prune=now
