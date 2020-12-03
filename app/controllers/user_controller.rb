class UserController < ApplicationController
    get '/' do  # login page
        @error = ""
        erb :login
    end

    # CREATE
    get '/new' do   # signup
        erb :new
    end

    post '/new_user' do
        user = User.new(params)

        if user.username == "" || user.password == "" || User.find_by_username(params["username"])
            redirect '/new'
        else
            user.save
            session[:user_id] = user.id
            redirect '/'
        end
    end

    # RETRIEVE
    post '/' do
        user = User.find_by_username(params["username"])
        
        if !!user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/user/#{ user.id }"
        else
            @error = "Invalid Credentials. Try Again."
            erb :login
        end
    end

    get '/user/:id' do  # 1 user
        @session = User.find_by_id(session[:user_id])
        erb :show
    end

    # UPDATE
    get '/user/:id/edit' do # edit
        @session = User.find_by_id(session[:user_id])
        erb :edit
    end

    patch '/user/:id' do
        user = User.find_by_id(session[:user_id])
        user.update(username: params[:username])

        redirect "/user/#{ user.id }"
    end

    # DELETE
    delete '/user/:id' do
        user = User.find_by_id(session[:user_id])
        user.destroy

        redirect '/'
    end

    get '/logout' do
        session.delete(:user_id)
        redirect '/'
    end
end