class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :cyclist
      t.belongs_to :ride 
      t.string :title
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
