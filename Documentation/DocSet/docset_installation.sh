#!/bin/sh

# This script will copy the docset to your library in order be used with Xcode

(
DOC_SET_DESTINATION="$HOME/Library/Developer/Shared/Documentation/DocSets/"
echo "This will install the docset from the current folder into $DOC_SET_DESTINATION"
echo "Starting to copy"
\ls -d *.docset | xargs -I {} cp -R {} $DOC_SET_DESTINATION
echo "Installation complete. Please restart Xcode."
)