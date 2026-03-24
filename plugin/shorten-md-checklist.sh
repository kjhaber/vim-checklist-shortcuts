#!/bin/sh
# shorten-md-checklist
#
# Takes markdown checklist file as input.  Assumption is that checklist is in
# bulleted list with either dash or asterisk bullet characters, possibly under
# markdown L2+ headings. The shortened version keeps only the checklist items
# with asterisk bullets that aren't marked complete.  If a markdown L2+ section
# heading is empty, it is omitted.  Duplicate blank lines are also omitted.
#
# Idea is that the "full" checklist contains both asterisk and dash bullet
# types.  Example is a grocery list with everything I might go shopping for.
# When preparing to go grocery shopping, I fill in the full checklist,
# unchecking the items I plan to buy and setting their bullet to asterisk.
# (Part of the reason for the choice of asterisk is the Markor markdown editor
# app for Android: when it toggles a checkbox in a bullet list, it sets the
# bullet to an asterisk.  This is the app I use on my phone in the store when
# I'm shopping for groceries.)
#
# Validate input file is provided
if [ -z "$1" ]; then
  echo "No input file provided, exiting"
  exit 1
fi

# awk script to omit empty L2+ section headers.  Idea is that as awk iterates
# over each line in the file, it prints the previous line when the current
# line isn't empty AND an L2 section header.  An END block is used to handle
# printing the last line of the file.
AWK_OMIT_EMPTY_HEADER_SECTIONS="""
{
  if ((NR > 1 && prevline !~ /##/) || (\$0 != \"\" && prevline != \"\")) {
    print prevline
  }
  prevline = \$0
}
END {
  if (prevline != \"\") {
    print prevline
  }
}
"""

# This sed command prints lines in the file that start with '#' (markdown
# headings), lines that start with literal "* [ ]", or empty lines.
# The 'uniq' line cleans up any spare duplicate blank lines.
sed -En '/(^#)|(^\* \[ \])|(^$)/p' < "$1" \
  | awk "$AWK_OMIT_EMPTY_HEADER_SECTIONS" \
  | uniq

