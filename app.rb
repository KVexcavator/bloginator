require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
	@db=SQLite3::Database.new 'bloginator.db'
	@db.results_as_hash=true
end

before do
	init_db
end

configure do
	init_db
	@db.execute "CREATE TABLE IF NOT EXISTS posts (
										`id`	INTEGER PRIMARY KEY AUTOINCREMENT,
										`created_date`	DATE,
										`text`	TEXT										
										)"
end

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
	content= params[ :content ]
	erb "You typed: #{content}."
end