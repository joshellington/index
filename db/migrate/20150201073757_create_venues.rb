class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :city
      t.string :name
      t.string :url
      t.string :country
      t.string :state
      t.integer :score
      t.string :postal_code
      t.float :lat
      t.float :lng
      t.string :address
      t.integer :seatgeek_id

      t.timestamps
    end
  end
end
