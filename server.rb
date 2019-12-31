require "sinatra/activerecord"
require "sinatra"
require "./models"


set :database, {adapter: "sqlite3", database: "blog.sqlite3"}
enable :sessions

get '/' do #signup here
  erb :start
end

post '/' do #CREATE new user to go be INSERTed to database
  @user = User.new(params[:user])

  session[:user_id] = @user.id
  p session[:user_id]
  @user.save
  redirect "/profile"

end

get "/profile" do

  # redirect '/' unless
  # session[:user_id]
  erb :profile

end
get '/login' do

  erb :login
end

post '/login' do
  pp params
  user = User.find_by(:user['email'])
end
