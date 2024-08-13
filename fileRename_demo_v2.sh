#!/bin/bash
#
# %last updated August 2024 by Eric
# github: EPH1123
#
# Purpose: Rename files in a batch, following a regular expression search defined in-line below;
#
# Assumptions: this code only processes .txt files (ignores all other extensions or missing extensions); this can be changed by updating REGEX, the pattern searched
#
# Number of files is left unchanged & file contents are unchanged;
# The original filenames are NOT saved, but are output to the terminal
#
# This script is part of a series of short code examples with similar
# function, across different languages.
#
# There are likely several other approaches to accomplish the same goal,
# depending on operating system.
#
#
# Development Method:
# I started with draft code from a copilot tool, then made edits to match the Matlab example in this repo
#
# draft code was created using an OpenAI GPT4o variant, with my edits marked "EPH1123:"
#
#
#Sources:
# Code Copilot
# By promptspellsmith.com
# accessed via openai.com ,  July 2024
#
# https://www.gnu.org/software/bash/manual/bash.html   #Bash reference manual


#output from Copilot
#	"Sure, let's create a Bash script to rename all files in a directory that match a given regular expression. Here's the plan:"

	#"1. Define the directory to search for files.
	# 2. Define the regular expression to match filenames.
	# 3. Loop through all files in the directory.
	# 4. If a file matches the regular expression, rename it."

	# "Here is the Bash script:"


# Inputs
# Define the directory and the regular expression
DIRECTORY="./demo/"  # OK to include or leave off ending /      checked below
REGEX=".*[bB]ob.*\.txt"
#EPH1123: setup to match my example code from the other languages in this repo; only operate on .txt files
# REGEX must end with a file extension like .txt 
#or it can end with this wildcard, if you want to process all file extensions:  "\..*"


# Define the new name pattern
NEW_NAME_BASE="Alice_new_"  #EPH1123: append a string instead of using the same new name for all files 

# #EPH1123: check & drop any ending / character on directory string (not needed)
DIRECTORY=${DIRECTORY%/}    #see ${parameter%word} pattern match in gnu help
#echo  $DIRECTORY

# Loop through all files in the directory
for FILE in "$DIRECTORY"/*; do
    # Check if the file matches the regular expression
	
	
    if [[ $FILE =~ $REGEX ]]; then   #EPH1123: the =~ operator checks for regEx match, per gnu.org reference manual
        # #(not needed) Get the extension of the file
        #EXTENSION="${FILE##*.}"

		FILEName=$(basename "$FILE")  #EPH1123: FILEName=file's name without directory
        
		# Generate the new file name
		# #EPH1123: instead of a fixed new name, append to the original
        NEW_FILE="$DIRECTORY/${NEW_NAME_BASE}${FILEName}"  #.${EXTENSION}
        # Rename the file
        mv -n "$FILE" "$NEW_FILE" 
		#EPH1123: if new file name exists, do nothing; use -n to avoid overwrite & possible loss of data

		echo "Renaming $FILE to $NEW_FILE" # EPH1123: print verbose log to confirm
    fi
done

# ### Explanation:
# 1. `DIRECTORY` is the directory to operate in.
# 2. `REGEX` is the regular expression pattern to match the files you want to rename.
# 3. `NEW_NAME_BASE` is the new name pattern.
# 4. The script loops through all files in the specified directory.
# 5. If a file matches the regular expression, it extracts the file extension and renames the file to the new name pattern with the same extension.

# ### Usage:
# 1. Save the script to a file, e.g., `rename_files.sh`.
# 2. Make the script executable: `chmod +x rename_files.sh`.
# 3. Run the script: `./rename_files.sh`.