function taskhelp
  echo '
task add "Stuff" project:stuff - Add a task to a project
task <id> done                 - Complete a task
task <id> start                - Start a task
task list                      - List tasks
'
end

# Print task list on each opening
# https://taskwarrior.org/docs/examples.html
task list
