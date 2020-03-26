# File: commands.gdb
# Purpose: Automate gdb commands during automated execution
# Usage:
# 	gdb -x automated.gdb <binary>

# GDB COMMANDS
# 1. Redirect output
# Send logging to a file
set logging file ./devops/logs/temp_electric_fence.log
# Only sent logging to the file
set logging redirect on
# Overwrite the contents of that file
set logging overwrite on
# Now that logging is configured, start
set logging on

# 2. Run the binary
run > /dev/null 2>&1

# 3. Exit gdb
quit
# Stop any debugging sessions still in execution
y

