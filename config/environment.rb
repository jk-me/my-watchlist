# ENV['SINATRA_ENV'] ||= "development"
#
# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])
#
# ActiveRecord::Base.establish_connection(
#   :adapter => "postgresql",
#   :database => "db/#{ENV['SINATRA_ENV']}"
# )
# #object relational mapping framework, maps db to oo programming
#
# require_all 'app'

require 'bundler/setup'
Bundler.require
require_all 'app'

configure :development do
  ENV['SINATRA_ENV'] ||= "development"
  require 'bundler/setup'
  Bundler.require(:default, ENV['SINATRA_ENV'])

  ActiveRecord::Base.establish_connection(
    :adapter => "postgresql",
    :database => "db/#{ENV['SINATRA_ENV']}"
  )

end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end
