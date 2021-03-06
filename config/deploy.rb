set :application, 'push_admin'
set :repo_url, 'git@github.com:sleepinglion/push_admin.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/push_admin'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
set :pty, true
set :linked_files, %w{config/database.yml .env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/assets public/ckeditor public/uploads}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
         execute :rake, 'tmp:clear'
      end
    end
  end

  after :finishing, 'deploy:cleanup'
end
