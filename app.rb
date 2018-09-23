require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require "sinatra/activerecord"

# подключение к базе данных
set :database, "sqlite3:blog.db"

before do

end

#создание сущности блог
# создание таблицы posts (`created_date`	DATE,`text`	TEXT )
#создание таблицы comments(`created_date`	DATE,	`comment_text`	TEXT,	'post_id'	INTEGER	)
class Blog<ActiveRecord::Base
end

get '/' do

	# вывод списка постов из таблицы post
	@result=@db.execute "SELECT * FROM posts ORDER BY id DESC"

	erb :index		
end

get '/main' do
  erb "Hello Main"
end

get '/new' do
  erb :new
end

post '/new' do

	#вывод ощибки при отправке пустой формы
	content= params[ :content ]

	if content.length < 1

		@error ="Type post text"
		return erb :new

	end

	# созранение данных в таблицу posts
	@db.execute "INSERT INTO posts (text, created_date)
	            VALUES ( ? , datetime())", [content]

	# перенаправление на главную страницу
	redirect to "/"
	
end


get '/detals/:post_id' do

	 # получаем переменную из URL
	 post_id= params[ :post_id]
	 # делаем выборку одного поста
	 result=@db.execute "SELECT * FROM posts WHERE id= ? ",[post_id]
	 @row=result[0]

	 # выборка коментариев
	 @comments=@db.execute "SELECT * FROM comments WHERE post_id=? ORDER BY id",[post_id]

	 erb :detals
end

# щбработчик коментариев
post '/detals/:post_id' do
	post_id= params[ :post_id]
	content= params[ :content ]
  @db.execute "INSERT INTO comments (comment_text, post_id, created_date)
	            VALUES ( ? , ? , datetime())", [content,post_id]

	# перенаправление на главную страницу
	redirect to "/detals/"+post_id
  
end