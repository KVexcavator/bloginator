class CreateBlog < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :date   
      t.timestamp 
     end

    create_table :comments do |t|
      t.text :comment_text  
      t.integer :post_id 
      t.timestamp 
    end
  end
end
