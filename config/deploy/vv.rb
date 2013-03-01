set :rails_env, "production"
set :repository,  "git@192.168.1.100:bbtang/guanxingtang.git"
server "192.168.1.100", :app, :web, :db, :primary => true
