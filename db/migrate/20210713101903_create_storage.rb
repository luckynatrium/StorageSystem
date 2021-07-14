class CreateStorage < ActiveRecord::Migration[6.1]
  def up
    create_table :storages do |t|
      t.string :name, :unique
      t.timestamps
    end
  end

  def down
    drop_table :storages
  end
end
