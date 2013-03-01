set :rails_env, "production"
set :repository,  "git@bbtang.com:bbtang/guanxingtang.git"
server "bbtang.com", :app, :web, :db, :primary => true
