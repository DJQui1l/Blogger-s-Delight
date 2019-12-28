require "sinatra/activerecord"
require "sinatra"
require "./models"


set :database, {adapter: "sqlite3", database: "blog.sqlite3"}
enable :sessions

get '/' do #signup here
  erb :start
end

post '/' do #CREATE new user to go be INSERTed into database
  @user = User.new{params['user']
  }

  # if @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect  '/profile'
  # end
  redirect '/profile'

end

# get '/signup' do
#   erb :signup
#
# end
#
# post '/signup' do
#
# end

get '/login' do
  erb :login
end

post '/login' do

end

get '/profile' do
  redirect '/' unless
  session[:user_id]
  erb :profile

end
