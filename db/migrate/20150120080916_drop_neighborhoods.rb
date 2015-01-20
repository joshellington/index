class DropNeighborhoods < ActiveRecord::Migration
  def up
    drop_table :neighborhoods
  end

  def down
    create_table :neighborhoods do |t|
      t.string :name
      t.references :business

      t.timestamps
    end
    add_index :neighborhoods, :business_id
  end
end
