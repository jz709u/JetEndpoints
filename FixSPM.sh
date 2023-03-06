#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'Please call the script with the name of your project as it appears in the derived data directory. Case-insensitive.'
    echo 'For example: ./fix-spm-cache.sh myproject'
    exit 0
fi

# Delete all directories named "remotes" from the global Swift Package Manager cache.
cd ~/Library/Caches/org.swift.swiftpm/repositories

for i in $(find . -name "remotes" -type d); do
    echo "Deleting $i"
    rm -rf $i
done

# Find derived data directories for all projects matching the script argument, and
# delete all directories named "remotes" from source package repositories cache for those projects.

cd ~/Library/Developer/Xcode/DerivedData/

for project in $(find . -iname "$1*" -type d -maxdepth 1); do
    for i in $(find "$project/SourcePackages/repositories" -name "remotes" -type d); do
        echo "Deleting $i"
        rm -rf $i
    done
done
