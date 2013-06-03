set :rails_env, "production"
set :user, 'andersen'
set :deploy_to, "/home/#{user}/deployments/#{application}"
server "notes18.com", :app, :web, :db, :primary => true
