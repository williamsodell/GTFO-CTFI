require "bundler/setup"
require "sinatra/base"

class GTFOCTFI < Sinatra::Base
  get "/" do
    erb :index
  end
end