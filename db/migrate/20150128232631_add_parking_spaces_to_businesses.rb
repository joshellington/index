class AddParkingSpacesToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :parking_spaces, :integer
  end
end
