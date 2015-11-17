set :application, 'Lections'
set :repo_url, 'https://max_sveshnikov:apple123@bitbucket.org/maxsoft777/lections.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :bundle_flags, '--quiet'   # '--deployment --quiet' is the default

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/ubuntu/lections'

# Default value for :linked_files is []
#set :linked_files, %w(db/production.sqlite3)

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 3 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
end
