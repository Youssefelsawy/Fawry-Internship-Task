# Q1: Custom Command (mygrep.sh)
## Reflective Section Answers
  ### 1. Argument Handling Breakdown
- The script processes arguments in several stages:
- First, it parses options (-n, -v, --help) using a while loop and case statement
- The first non-option argument is treated as the search string
- The second non-option argument is treated as the filename
- It validates that both required arguments exist and the file is readable
- For each line in the file, it performs a case-insensitive match and applies the options

### 2. Supporting Additional Features
 - To support regex or other options like -i, -c, -l:
- I would add more case statements in the option parsing section
- For regex support, I'd replace the simple string matching with grep -E or awk
- The script structure would remain similar, but the matching logic would become more complex
- I might use getopts for more robust option handling
 
### 3. Hardest Part to Implement
- The most challenging part was handling combined options (-vn or -nv) while maintaining clean code. Initially, I considered using getopts, but for this simple case, a manual approach was  more straightforward. The case-insensitive matching also required careful testing to ensure it worked correctly with different character cases.

### Bonus Features:

- Added a --help option to display usage instructions.
- Improved handling of command-line arguments with getopts for cleaner and more efficient option parsing.

## Q2: Internal Service Unreachable
i have recieved one email which indicated that the deadline updated but never recieved any email before that indicates to the task so i have only one day to do so i tried it internally with my os (windows) 
