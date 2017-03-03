class AddAddressToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :g_address, :string
  end
end
