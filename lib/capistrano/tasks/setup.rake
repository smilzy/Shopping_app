# Some useful tasks which can be executed with
# cap STAGE_NAME setup:TASK_NAME
# eg. cap staging setup:restart_app
namespace :setup do

  desc "Seed the database."
  task :seed_db do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Restart App."
  task :restart_app do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          #execute :rake, "db:seed"
          execute "cd #{release_path} devil www restart #{fetch(:domain)}"
        end
      end
    end
  end

end