class ChangeTypeToTitleOnParkingtypes < ActiveRecord::Migration
  def change
    rename_column :parkingtypes, :type, :title
  end
end
