class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.belongs_to :cyclist
      t.datetime :ride_date
      t.string :location
      t.text :description
      t.float :ride_distance 


      t.timestamps null: false
    end
  end
end
