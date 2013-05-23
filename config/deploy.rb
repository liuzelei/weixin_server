require "bundler/capistrano"

set :rvm_ruby_string ,  'ruby-1.9.3-p194@askjane' #这个值是你要用rvm的gemset。名字要和系统里有的要一样。
set :rvm_type ,  :user   # Don't use system-wide RVM
require 'rvm/capistrano'

set :stages, %w(mn online)
set :default_stage, "mn"
require 'capistrano/ext/multistage'

set :application, "weixin_server"
set :scm, :git
set :scm_username, 'git'
set :branch, "master"
set :user, 'bbt'
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_env, 'production'
set :deploy_to, "/home/#{user}/bbtang/#{application}"

set :keep_releases, 15

after 'deploy:update_code', 'deploy:migrate', "deploy:create_symlink", "rvm:trust_rvmrc", "deploy:cleanup"

namespace :deploy do

  task :start, :roles => :app, :except => { :no_release => true } do
    #run "cd #{current_path} && passenger start --socket /tmp/passenger.socket --daemonize --environment production"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    #run "cd #{current_path} && passenger stop --pid-file tmp/pids/passenger.pid"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    run "ln -nsf #{shared_path}/uploads #{current_path}/public/uploads"
  end

end

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

task :uname do
    run "uname -a"
end
