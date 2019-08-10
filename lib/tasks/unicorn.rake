namespace :unicorn_rails do
  # unicorn_rails task
  RAILS_ENV=ENV['RAILS_ENV']
  UNICORN_CMD='unicorn_rails'
  UNICORN_CONFIG=%Q(#{File.dirname(File.expand_path(__FILE__))}/../../config/unicorn.rb)
  UNICORN_PID=%Q(#{File.dirname(File.expand_path(__FILE__))}/../../tmp/pids/unicorn.pid)

  task :environment do
  end

  desc 'unicorn_rails start'
  task :start => :environment do

    sh %Q(/bin/bash -lc "bundle exec #{UNICORN_CMD} -c #{UNICORN_CONFIG} -E #{RAILS_ENV} -D")
  end

  desc 'unicorn_rails stop'
  task :stop => :environment do 
    if %x(ps ho pid p `cat #{UNICORN_PID}`).present?
      sh %Q(kill `cat #{UNICORN_PID}`)
    end
  end

  desc 'unicorn_rails graceful_stop'
  task :graceful_stop => :environment do
    if %x(ps ho pid p `cat #{UNICORN_PID}`).present?
      sh %Q(kill -s QUIT `cat #{UNICORN_PID}`)
    end
  end

  desc 'unicorn_rails reload'
  task :reload => :environment do
    if %x(ps ho pid p `cat #{UNICORN_PID}`).present?
      sh %Q(kill -s USR2 `cat #{UNICORN_PID}`)
    else
      Rake::Task['unicorn_rails:start'].execute
    end
  end

  desc 'unicorn_rails restart'
  task :restart => :environment do
    if %x(ps ho pid p `cat #{UNICORN_PID}`).present?
      Rake::Task['unicorn_rails:stop'].execute
    else
      puts %Q(unicorn didn't work.)
    end
    Rake::Task['unicorn_rails:start'].execute
  end
end