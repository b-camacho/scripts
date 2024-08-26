#!/bin/bash

# default remote is origin
remote=${1:-origin}

# Get the current remote URL
current_url=$(git remote get-url $remote)

# Check if the URL is already using SSH
if [[ $current_url == git@github.com:* ]]; then
    echo "Remote is already using SSH."
    exit 0
fi

# Extract the username and repository name from the HTTPS URL
if [[ $current_url =~ https://github.com/(.+)/(.+)\.git ]]; then
    username=${BASH_REMATCH[1]}
    repo=${BASH_REMATCH[2]}
else
    echo "Current remote URL is not in the expected HTTPS format."
    exit 1
fi

# Construct the new SSH URL
new_url="git@github.com:$username/$repo.git"

# Set the new remote URL
git remote set-url "$remote" "$new_url"

echo "Remote URL updated to: $new_url"
