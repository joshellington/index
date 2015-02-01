class AddEventIdToPerformers < ActiveRecord::Migration
  def change
    add_column :performers, :event_id, :integer
  end
end
