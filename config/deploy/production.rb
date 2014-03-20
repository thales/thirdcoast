default_run_options[:pty] = true
ssh_options[:forward_agent] = false

set :application,    "thirdcoastfestival"
set :repository,     "git@gitslice.com:third-coast-festival.git"
set :deploy_to,      "/home/apps/#{application}"
set :scm,            :git
set :use_sudo,       false
set :scm_verbose,    false
set :user,           "apps"
set :password,       "64594ece90"
set :production_all, "166.78.100.21"
set :rails_env,      "production"
set :keep_releases,  2 

role :web, production_all
role :app, production_all
role :db,  production_all, :primary => true

after  "deploy:create_symlink", "deploy:update_crontab"
after  "deploy:update_code",   "deploy:jammit"
after  "deploy:update_code",   "reconfigure_sphinx"
after  "deploy:update",        "thin:restart"
after  "deploy",               "deploy:cleanup"

namespace :deploy do
  desc 'Restart phusion passenger'
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc 'Compile assets with Jammit'
  task :jammit do
    run "cd #{current_release} && jammit -f -u http://www.thirdcoastfestival.org"
  end

  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && RAILS_ENV=#{rails_env} whenever --update-crontab #{application}"
  end
end

task :reconfigure_sphinx, :roles => [:app] do
#  symlink_sphinx_indexes
# thinking_sphinx.configure
#  thinking_sphinx.start
end

task :symlink_sphinx_indexes, :roles => [:app] do
  run "mkdir -p #{shared_path}/db/sphinx"
  run "rm #{current_release}/db/sphinx"
  run "ln -s #{shared_path}/db/sphinx #{current_release}/db/sphinx"
end

namespace :thin do
  task :start, :roles => :app do
    run "cd #{current_path} && thin start --config #{current_path}/config/thin.yml"
  end

  task :stop, :roles => :app do
    run "cd #{current_path} && thin stop --config #{current_path}/config/thin.yml"
  end

  task :restart, :roles => :app do
    run "cd #{current_path} && thin restart --config #{current_path}/config/thin.yml"
  end
end