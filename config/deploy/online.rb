set :rails_env, "production"
set :repository,  "git://github.com/as181920/demo_weixin.git"
server "bbtang.com", :app, :web, :db, :primary => true
