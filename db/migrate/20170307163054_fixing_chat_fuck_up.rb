class FixingChatFuckUp < ActiveRecord::Migration[5.0]
  def change
    rename_column :posts, :read, :sender_read
    add_column :posts, :recipient_read, :boolean, :default => false
  end
end
