class CreateParkingOptions < ActiveRecord::Migration
  def change
    create_table :parking_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
