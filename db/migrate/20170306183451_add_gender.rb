class AddGender < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender, :string
    add_column :events, :gender, :string
  end
end
