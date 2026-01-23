#!/usr/bin/bash

REPO=${1:-"svr"}
# make the repository shared
git config core.$REPO group # or whatever other sharing option
# fix the setgid bit
find . -type d | xargs chmod g+s
# repair the permissions
chmod -R g+r *
