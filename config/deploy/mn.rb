set :rails_env, "production"
set :repository,  "git://github.com/as181920/demo_weixin.git"
set :deploy_to, "/home/#{user}/deployments/#{application}"
server "notes18.com", :app, :web, :db, :primary => true
