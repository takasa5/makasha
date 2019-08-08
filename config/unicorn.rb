File.expand_path: https://ruby-doc.org/core-2.2.0/File.html#method-c-expand_path
rails_root = File.expand_path('../../', __FILE__)
worker_processes 2
working_directory rails_root

listen "#{rails_root}/tmp/unicorn.sock" 
pid "#{rails_root}/tmp/unicorn.pid" 

stderr_path "#{rails_root}/log/unicorn_error.log"
stdout_path "#{rails_root}/log/unicorn.log"