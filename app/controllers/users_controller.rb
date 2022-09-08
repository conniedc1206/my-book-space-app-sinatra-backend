class UsersController < ApplicationController
  # get all users
  get "/users" do
    User.all.to_json
  end
  
  # get individual user object, include logs
  get "/users/:id" do
    # binding.pry
    user = User.find(params[:id])
    # find all the logs of that user
    # logs = user.logs
    # send the response to json
    user.to_json(include: [:logs])
  end

  # User Registration
  post "/users" do
    # use the data in params to create a new user and log them in by
    @user = User.new(first_name: params["first_name"], last_name: params["last_name"], email: params["email"], password: params["password"]) #{"first_name"=>"A", "last_name"=>"A", "email"=>"A@test.com", "password"=>"Apw"}
    # setting the session[:id] equal to the user's id here
    # session[:id] = user.id
    # this redirect takes us to the route: get '/users/home' that is in the Users Controller (go and look at that route in the Users Controller.)
    # redirect '/users/home'
    @user.save
    @user.to_json
  end

  # User Logging In
  post "/login" do
    # find the user by email/password
    user = User.find_by(params) #{"email"=>"test@test.com", "password"=>"testpw"}
    # setting the session[:id] equal to the user's id here
    # session[:user_id] = user.id
    # send the response to json
    user.to_json(include: [:logs])

  end

  # when user clicks "logout" button, use this endpoint
  delete '/logout' do
    session.clear
  end
end