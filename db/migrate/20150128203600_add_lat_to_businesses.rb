class AddLatToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :businesses, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
