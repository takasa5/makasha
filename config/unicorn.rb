rails_root = File.expand_path('../../', __FILE__)
worker_processes 2
working_directory rails_root

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{rails_root}/Gemfile"
end

listen "#{rails_root}/tmp/unicorn.sock" 
pid "#{rails_root}/tmp/unicorn.pid" 

stderr_path "#{rails_root}/log/unicorn_error.log"
stdout_path "#{rails_root}/log/unicorn.log"