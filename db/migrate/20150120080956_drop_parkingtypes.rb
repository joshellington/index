class DropParkingtypes < ActiveRecord::Migration
  def up
    drop_table :parkingtypes
  end

  def down
    create_table :parkingtypes do |t|
      t.string :title
      t.references :business

      t.timestamps
    end
    add_index :parkingtypes, :business_id
  end
end
