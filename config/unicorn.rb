# Set the working application directory
 working_directory "/var/www/nice-marmot"

 # Unicorn PID file location
 # pid "/path/to/pids/unicorn.pid"
 pid "/var/www/nice-marmot/pids/unicorn.pid"

 # Path to logs
 # stderr_path "/path/to/log/unicorn.log"
 # stdout_path "/path/to/log/unicorn.log"
 stderr_path "/var/www/nice-marmot/log/unicorn.log"
 stdout_path "/var/www/nice-marmot/log/unicorn.log"

 # Unicorn socket
 listen "/tmp/unicorn.[app name].sock"
 listen "/tmp/unicorn.nice-marmot.sock"

 # Number of processes
 # worker_processes 4
 worker_processes 2

 # Time-out
 timeout 30
