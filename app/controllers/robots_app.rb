require 'models/robots'

class RobotsApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    @average_age = Robots.average_age
    erb :dashboard
  end

  get '/robots' do
    @robots = Robots.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    Robots.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = Robots.find(id.to_i)
    erb :robot
  end

  get '/robots/:id/edit' do |id|
    @robot = Robots.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    Robots.edit(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    Robots.delete(id.to_i)
    redirect '/robots'
  end
end
