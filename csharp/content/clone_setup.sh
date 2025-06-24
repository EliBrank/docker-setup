#!/bin/bash

# pull github credentials from env variables
# set to empty strings if not avaialable
GIT_EMAIL=${GIT_EMAIL:-""}
GIT_USER=${GIT_USER:-""}
GIT_TOKEN=${GIT_TOKEN:-""}

# prompt user for any missing credentials

if [ -z "$GIT_EMAIL" ]; then
  read -p "Enter your GitHub email: " GIT_EMAIL
fi

if [ -z "$GIT_USER" ]; then
  read -p "Enter your GitHub username: " GIT_USER
fi

if [ -z "$GIT_TOKEN" ]; then
  read -p "Enter your GitHub token: " GIT_TOKEN
fi

# prompt for github repo if not provided with script invocation
if [ -n "$1" ]; then
  gitRepo="$1"
else
  read -p "Please paste the link to the GitHub repo you wish to clone: " gitRepo
fi

# isolate repo information from link provided
gitRepo=$(echo "$gitRepo" | sed 's|https://||')
repoName=$(echo ${gitRepo%.git} | awk -F "/" '{print $NF}')

git clone "https://$GIT_TOKEN@$gitRepo" "$repoName"

# set config for repo
if [ -z "$(git config --global user.email)" ]; then
  git config --global user.email "$GIT_EMAIL"
fi

if [ -z "$(git config --global user.name)" ]; then
  git config --global user.name "$GIT_USER"
fi

echo "successfully cloned repo: $repoName"
