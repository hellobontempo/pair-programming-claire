class ApplicationController < Sinatra::Base
    configure do
        enable :sessions
        set :session_secret, 'password'
        set :views, 'app/views'
        set :public, 'public'
    end
end