class AddColumnFriendUidsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :friend_uids, :string, array: true, default: []
  end
end
