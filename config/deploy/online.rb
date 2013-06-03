set :rails_env, "production"
set :user, 'bbt'
set :deploy_to, "/home/#{user}/bbtang/#{application}"
server "bbtang.com", :app, :web, :db, :primary => true
