require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "This is Bloginator!"			
end

get '/main' do
  erb "Hello Main"
end

get '/new' do
  erb "Hello new post"
end