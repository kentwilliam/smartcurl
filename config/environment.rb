class WebApp < Sinatra::Base
  configure do
    set :upload_path, 'public/uploads/'
  end
end