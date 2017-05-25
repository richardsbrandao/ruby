require 'concurrent'

task = Concurrent::TimerTask.new(run_now: true, execution_interval: 5, timeout_interval: 5){puts 'Execution each 5 seconds'}
task.execute

sleep 15