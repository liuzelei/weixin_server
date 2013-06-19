set :rails_env, "production"
set :user, 'andersen'
set :deploy_to, "/home/#{user}/deployments/#{application}"
set :sidekiq_pid, "#{deploy_to}/current/tmp/pids/sidekiq.pid"
server "notes18.com", :app, :web, :db, :primary => true
