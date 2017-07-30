# config valid only for current version of Capistrano
lock "3.9.0"

set :application, "depot_app"
set :repo_url, "git@bitbucket.org:Smilzy/depot.git"
set :rvm_type, :user

# set :linked_files, fetch(:linked_files, []).push('config/database.yml', '.env')
append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }

set :bundle_binstubs, nil
set :linked_dirs, ['log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads/user', 'public/uploads/micropost']
set :normalize_asset_timestamps, %{public/images public/javascripts public/stylesheets public/assets}
set :assets_roles, [:web, :app]

  namespace :deploy do
  after :published, :symlink_to_public_ruby do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute "rm #{fetch(:deploy_to)}/public_ruby"
      execute "ln -s #{fetch(:release_path)} #{fetch(:deploy_to)}/public_ruby"
    end
  end
end