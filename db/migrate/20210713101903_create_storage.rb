class CreateStorage < ActiveRecord::Migration[6.1]
  def up
    create_table :storages do |t|
      t.string :name
      t.timestamps
    end
    add_index :storages, :name, unique: true
  end

  def down
    drop_table :storages
  end
end
