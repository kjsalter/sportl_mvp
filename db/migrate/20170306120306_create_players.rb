class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.references :event, :null => false
      t.references :user, :null => false
      t.timestamps
    end
  end
end
