class AddRequirementsToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :level, :integer
    add_column :events, :requirements, :text
  end
end
