#!/usr/bin/bash

COMMAND_DESTINATION_PATH=src/Infrastructure/Command
DEFAULT_COMMAND_PATH=src/Command
# Run symfony command to create a console command
symfony console make:command

# Move the console command created in src/Command folder into src/Infrastructure/Command destination folder
mv $DEFAULT_COMMAND_PATH/*  $COMMAND_DESTINATION_PATH

# Remove src/Command folder created by symfony command
rm -rf $DEFAULT_COMMAND_PATH

# Get the console filename newly created
FILE_NAME=$(ls -lt $COMMAND_DESTINATION_PATH | head -2 | awk '{print $9}' | xargs)
# Update the console command namespace
sed -i 's/App\\Command/App\\Infrastructure\\Command/g' $COMMAND_DESTINATION_PATH/$FILE_NAME

# Add the console command in stagging area
git add $COMMAND_DESTINATION_PATH/$FILE_NAME

