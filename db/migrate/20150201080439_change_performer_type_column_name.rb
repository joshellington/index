class ChangePerformerTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :performers, :type, :performer_type
    rename_column :events, :type, :event_type
  end
end
