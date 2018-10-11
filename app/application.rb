Dir.glob('./app/**/*.rb').each { |file| require file }

module Panadoura
  class Application < Sinatra::Base
    register Sinatra::Namespace

    configure do
      enable :cross_origin
    end

    before do
      response.headers['Access-Control-Allow-Origin'] = '*'
    end

    namespace '/api' do
      get '' do
        content_type :json

        { msg: "Hello, World!" }.to_json
      end

      post '/auth/twitter' do
        content_type :json

        { msg: "Hello, Twitter" }.to_json
      end
    end

    get '/' do
      File.read('app/public/index.html')
    end

    options "*" do
      response.headers["Allow"] = "GET, POST, OPTIONS"
      response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
      response.headers["Access-Control-Allow-Origin"] = "*"
      200
    end

    # Twitter auth
    # use OmniAuth::Builder do
    #   provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    # end
    #
    # get '/' do
    #   erb :timer
    # end
    #
    # get '/login' do
    #   redirect to("/auth/twitter")
    # end
    #
    # get '/auth/twitter/callback' do
    #   response = env['omniauth.auth']
    #
    #   if response
    #     user_repo = ROMConfig.new.repository(UserRepository)
    #     user = user_repo.by_uid(response.uid)
    #     unless user
    #       user = user_repo.create(username: response.info.nickname, uid: response.uid)
    #     end
    #
    #     session[:user] = user.to_h
    #     redirect to '/'
    #   else
    #     halt(401, 'Unauthorized')
    #   end
    # end
    #
    # get '/logout' do
    #   logout!
    #   redirect to '/'
    # end
    #
    # get '/tracker' do
    #   if logged_in?
    #     entry_repo = ROMConfig.new.repository(EntryRepository)
    #     @entries = entry_repo.by_user_id(current_user[:id])
    #
    #     erb :tracker
    #   else
    #     halt(401, 'Unauthorized')
    #   end
    # end
    #
    # post '/entry' do
    #   if logged_in?
    #     entry_repo = ROMConfig.new.repository(EntryRepository)
    #     new_entry = entry_repo.create(length: params[:length], created_at: DateTime.now, user_id: current_user[:id])
    #
    #     halt(200)
    #   else
    #     halt(401, 'Unauthorized')
    #   end
    # end
  end
end
