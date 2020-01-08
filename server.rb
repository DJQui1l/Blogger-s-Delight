require "sinatra/activerecord"
require "sinatra"
require "./models"
require "pg"


set :database, {adapter: 'postgresql',
                database: 'blog',
                username: 'postgres',
                password: ENV['POSTGRES_PW']
}

enable :sessions
# use Rack::Session::Pool


get '/' do #signup here




    erb :start

end


post '/' do #CREATE new user to go be INSERTed to database
  @user = User.new(params[:user])

  @user.save
  session[:user_id] = @user.id
  pp session[:user_id]
  redirect "/profile/#{@user.id}"

end
# #=======================================
get '/login' do

  erb :login
end
# #=======================================


post '/login' do

  @user = User.find_by(email: params[:user]['email'])

  @given_password = params[:user]['password']

  if @user.password == @given_password
    session[:user_id] = @user.id

    redirect "/profile/#{@user.id}"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# #=======================================
get "/profile" do

  if session[:user_id] != nil
    @user = User.find_by(id: session[:user_id])
    redirect "/profile/#{@user.id}"
  else
    redirect '/'
  end
end


get "/profile/:id" do

  @user = User.find_by(id: session[:user_id])
  # pp @user

  # redirect '/' unless
  # session[:user_id]

  erb :nav, :layout => :profile




  rescue ActiveRecord::RecordNotFound
    puts 'ERROR 404'
    erb :start
end



#
# #=======================================

get '/feed' do
  # get user ID from session
  if session['user_id']
    @posts = Post.all
    @user = User.find_by(id: @posts.user_id)
    erb :nav, :layout => :feed

  else
    'Not logged in'
      redirect '/'
  end
end


post '/feed' do

  if session['user_id'] #if someone is logged in, enable posting

    @post = Post.new(content: params['content'], user_id: session[:user_id])
    if @post.valid?
      @post.save

      redirect '/feed'
    end

  end
end


get '/delete' do

  # erb :delete

end
