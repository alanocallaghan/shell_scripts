#!/usr/bin/env bash

JSON=$(curl -s https://api.github.com/repos/qupath/qupath/releases)
SEDQUERY='s/.*: ([0-9]+),/\1/'

for OS in "Mac" "Win" "Linux"; do
    echo "QuPath downloads for $OS: "$(echo $JSON | jq ".[] | select(.prerelease==false) | .assets | .[] | select(.name? | match(\"$OS\"))"  |  grep download_count | sed -E -e "$SEDQUERY" | paste -sd+ | bc)
done
echo "Total QuPath downloads (including pre-release): " $(echo $JSON | jq | grep download_count | sed -E -e "$SEDQUERY" | paste -sd+ | bc)
echo "Total QuPath downloads: " $(echo $JSON | jq '.[] | select(.prerelease==false)' |  grep download_count | sed -E -e "$SEDQUERY" | paste -sd+ | bc)
