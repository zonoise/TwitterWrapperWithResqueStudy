require 'resque'
require 'daemon_spawn'
$:.unshift File::dirname(__FILE__) + '/../lib'
require 'twitter_wrapper_job'

class ResqueWorkerDaemon < DaemonSpawn::Base
  def start(args)
    @worker = Resque::Worker.new('*')
    @worker.log "Starting worker"
    @worker.verbose = true
    @worker.work
  end

  def stop
    @worker.try(:shutdown)
  end
end

ResqueWorkerDaemon.spawn!({
  :working_dir => './',
  :pid_file => './resque_worker.pid',
  :log_file => './resque_worker.log',
  :sync_log => true,
  :singleton => true
})


