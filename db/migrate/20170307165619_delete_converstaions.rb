class DeleteConverstaions < ActiveRecord::Migration[5.0]
  def change
    drop_table :conversations
    drop_table :messages
  end
end
