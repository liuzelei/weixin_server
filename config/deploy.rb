require "bundler/capistrano"

set :rvm_ruby_string ,  'ruby-1.9.3-p194@askjane' #这个值是你要用rvm的gemset。名字要和系统里有的要一样。
set :rvm_type ,  :user   # Don't use system-wide RVM
require 'rvm/capistrano'

require 'sidekiq/capistrano'

require 'capistrano/ext/multistage'
set :stages, %w(mn online)
set :default_stage, "mn"

set :application, "weixin_server"
set :scm, :git
set :scm_username, 'git'
set :repository,  "git://github.com/as181920/weixin_server.git"
set :branch, "master"
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_env, 'production'

#set :bundle_cmd, proc {"cd #{current_release} && bundle"}
set :bundle_cmd, 'source $HOME/.bash_profile && bundle'

set :sidekiq_cmd, "#{bundle_cmd} exec sidekiq"
set :sidekiqctl_cmd, "#{bundle_cmd} exec sidekiqctl"
set :sidekiq_timeout, 1000
set :sidekiq_role, :app
set :sidekiq_pid, "#{current_path}/tmp/pids/sidekiq.pid"
set :sidekiq_processes, 3

set :keep_releases, 15

set :user, 'andersen'
set :deploy_to, "/home/#{user}/deployments/#{application}"

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
