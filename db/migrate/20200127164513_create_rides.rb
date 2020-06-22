class CreateRides < ActiveRecord::Migration[6.0]
  def change
    create_table :rides do |t|
      t.string :title
      t.string :location
      t.text :description
      t.string :ride_distance
      t.string :ride_date
      t.integer :user_id
      t.integer :ride_id
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false


      t.timestamps null: false
    end
  end
end
