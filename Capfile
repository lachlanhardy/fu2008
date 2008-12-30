# load 'deploy' if respond_to?(:namespace) # cap2 differentiator
# Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
# load 'config/deploy'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

default_run_options[:pty] = true

# be sure to change these
set :user, 'fu2008'
set :domain, 'fuckyou2008.com'
set :application, 'fu2008'

# the rest should be good
# set :repository,  "#{user}@#{domain}:git/#{application}.git" 
set :repository,  "git@github.com:lachlanhardy/#{application}.git"
set :deploy_to, "/var/www/#{application}" 
set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
# set :git_shallow_clone, 1
set :scm_verbose, true
# set :scm_username, 'lachlanhardy'
set :use_sudo, false
set :group, "deploy"
set :ssh_options, { :forward_agent => true } # this is so we don't need a appdeploy key

server domain, :app, :web

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end