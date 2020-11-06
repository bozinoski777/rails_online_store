#FIXME replace 1.2.3.4 with your IP address
server '3.127.85.189', user: 'deploy', roles: %w{web app db}
set :rails_env, 'production'
