require './config/environment'
# 
# if ActiveRecord::Migrator.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
# end
#rake gem used to execute tasks in bash; Rakefile

use Rack::MethodOverride #rack/shotgun are ruby gems used to build web servers
use UsersController
use MoviesController
use ShowsController
run ApplicationController
