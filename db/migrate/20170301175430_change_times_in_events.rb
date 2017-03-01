class ChangeTimesInEvents < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :start, :start_time
    rename_column :events, :end, :end_time
  end
end
