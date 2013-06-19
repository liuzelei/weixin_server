set :rails_env, "production"
set :user, 'bbt'
set :deploy_to, "/home/#{user}/bbtang/#{application}"
set :sidekiq_pid, "#{deploy_to}/current/tmp/pids/sidekiq.pid"
server "bbtang.com", :app, :web, :db, :primary => true
