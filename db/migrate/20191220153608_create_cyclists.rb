class CreateCyclists < ActiveRecord::Migration
  def change
    create_table :cyclists do |t|
      t.string :name
      t.string :email
      t.text :bio
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
