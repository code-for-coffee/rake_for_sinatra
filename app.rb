require './models/account'

enable :sessions

# access/store/retrieve session information from session
# this is a {}
# the session {}

Account.create({
  :name => 'Victoria',
  :password => 'puppy',
  :email => 'v@ga.co'
}).save

get '/' do
  Account.all.to_json
end

get '/login/:pwd' do
  @v = Account.create(:name => 'victoria', :password => 'puppy', :email => 'v@v.v')
  session[:is_logged_in] = @v.has_valid_password(params[:pwd])
  session[:username] = @v.name
  binding.pry
  {:logged_in => session[:is_logged_in]}.to_json
end

get '/mustbeloggedintosee' do
  binding.pry
  if session[:is_logged_in] == false || session[:is_logged_in] == nil
    "SECRETSSSSSS only logged in can haz see"
  else
    "you rock"
  end
end

get '/logout' do
  session[:is_logged_in] = nil
  "you have been logged out, peace out"
end
