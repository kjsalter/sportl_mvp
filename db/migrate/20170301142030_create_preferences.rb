class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.references :sport, :null => false
      t.references :user, :null => false
      t.timestamps
    end
  end
end
