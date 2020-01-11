require "sinatra/activerecord"
require "sinatra"
require "./models"
require "pg"


set :database, {adapter: 'postgresql',
                database: 'blog',
                username: 'postgres',
                password: ENV['POSTGRES_PW']
}

configure :production do
  set :database, {url: ENV['DATABASE_URL']}
end

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


get '/login' do

  erb :login
end



post '/login' do

  @user = User.find_by(email: params[:user]['email'])

  @given_password = params[:user]['password']

  if @user.password == @given_password && @user.active == true
    session[:user_id] = @user.id
    session[:active] = @user.active
    pp session[:user_id]
    pp session[:active]
    redirect "/profile/#{@user.id}"

  elsif @user.active == false
    session[:active] = false
    redirect '/deactivated'
  else
    redirect '/'

  end
end

get '/logout' do
  session.clear
  redirect '/'
end

# #=======================================
get "/profile" do

  if session[:user_id] != nil && session[:active] == true
    @user = User.find_by(id: session[:user_id])
    redirect "/profile/#{@user.id}"

  else
    redirect '/'
  end
end


get "/profile/:id" do
    if session['user_id'] && session[:active] == true #if logged in, find that user's profile
    if params[:id] == session[:user_id]
      @user = User.find_by(id: session[:user_id])

    else #else load other user's profile and feed
      if @user = User.find_by(id: params[:id]) == nil
        redirect '/feed'
      else
        @user = User.find_by(id: params[:id])

      end
    end

  else
    redirect '/'
  end
  erb :nav, :layout => :profile

  rescue ActiveRecord::RecordNotFound
    puts 'ERROR 404'
    erb :start
end



#
# #=======================================

get '/feed' do
  # get user ID from session
    if session['user_id'] && session[:active] == true
    @posts = Post.all
    # @users = User.find_by(id: @posts.user_id)``
    erb :nav, :layout => :feed



  else
    'Not logged in'
      redirect '/'
  end
end


post '/feed' do

  if session['user_id'] && session[:active] == true #if someone is logged in and is active, enable posting

    @post = Post.new(content: params['content'], user_id: session[:user_id])
    if @post.valid?
      @post.save

      redirect '/feed'
    end
  else
    redirect '/'

  end
end


delete '/profile/:id' do
    @user = User.find_by(id: params[:id], active: session[:active])
    @user.update(active: false)
    session.clear
    redirect '/deactivate-confirmed'
    #use a two step process

end
#
# get '/profile/deactivate-user' do
#   if session[:user_id] && session[:active] == true
#   erb :deactivate
#   end
# end
#
# post '/profile/deactivate' do
#     User.find_by(id: session[:user_id], password: params[:password]).active = false
#     redirect '/deactivate-confirmed'
#
# end
#
get '/deactivate-confirmed' do
  erb :deactivate_confirmed
end

get '/deactivated' do
  erb :deactivated
end

post '/deactivated' do
  if params[:reactivate]['yes']
    redirect '/reactivate'
  elsif params[:reactivate]['no']
    redirect '/'
  end

end

get '/reactivate' do
  if session[:active] != false
    redirect '/'
  else
    erb :reactivate

  end
end

post '/reactivate' do
  @user = User.find_by(email: params['email'],password: params['password'])
  pp @user
  if @user.active != false
    redirect '/'
  else
  @user.update(active: true)
  session[:user_id] = @user.id
  session[:active] = @user.active
  redirect "/profile/#{@user.id}"
  end
end
