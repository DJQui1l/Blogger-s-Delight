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
  puts session[:user_id]

  @user.save
  redirect "/profile/#{@user.id}"

end
# #=======================================
get '/login' do

  erb :login
end

post '/login' do

  @user = User.find_by(email: params[:user]['email'])

  given_password = params[:user]['password']

  if @user.password == given_password
    session[:user_id] = @user.id

    redirect "/profile/#{@user.id}"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# #=======================================
# get "/profile" do
#
#
#
# end
#
#
get "/profile/:id" do
  @user = User.find_by(id: params['id'])
  pp @user

  redirect '/' unless
  session[:user_id]

  erb :nav, :layout => :profile

  rescue ActiveRecord::RecordNotFound
    puts 'ERROR 404'
    erb :start



end
#
#
# get '/feed' do
#   # get user ID from session
#   if session['user_id']
#     erb :feed
#   else
#     'Not logged in'
#       redirect '/'
#   end
# end
#
# post '/feed' do
#
#   if session['user_id'] #if someone is logged in, enable posting
#     @post = Post.new(content: params['content'])
#     if @post.valid?
#       @post.user_id = session['user_id']
#       @post.save
#
#     end
#
#   end
# end
