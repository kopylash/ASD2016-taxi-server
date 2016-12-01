class InitialDbScheme < ActiveRecord::Migration
  def change

    create_table :drivers do |t|
      t.string :name
      t.string :phone
      t.string :car_model
      t.string :car_number
      t.float :latitude
      t.float :longitude
      t.integer :status
      t.timestamps
    end

    create_table :orders do |t|
      t.string :pickup_address
      t.string :dropoff_address
      t.float :pickup_lat
      t.float :pickup_lon
      t.float :dropoff_lat
      t.float :dropoff_lon
      t.string :client_name
      t.string :phone
      t.float :distance
      t.decimal :price, precision: 5, scale: 2
      t.boolean :completed
      t.integer :rating
      t.timestamps
      t.references :driver
    end

    add_foreign_key :orders, :drivers

  end
end
