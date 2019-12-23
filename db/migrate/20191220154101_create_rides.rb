class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :location
      t.text :description
      t.string :ride_distance
      t.string :ride_date
      t.integer :user_id


      t.timestamps null: false
    end
  end
end
