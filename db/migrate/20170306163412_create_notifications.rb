class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :content
      t.integer :notificationable_id
      t.string :notificationable_type
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
