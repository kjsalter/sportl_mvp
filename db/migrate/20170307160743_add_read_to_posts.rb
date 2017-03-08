class AddReadToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :read, :boolean, :default => false
  end
end
