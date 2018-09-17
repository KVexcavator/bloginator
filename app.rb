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
  erb :new
end

post '/new' do
	@content= params[ :content ]
	erb "You typed: #{@content}."
end