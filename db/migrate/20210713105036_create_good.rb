class CreateGood < ActiveRecord::Migration[6.1]
  def up
    create_table :goods do |t|
      t.string :name
      t.timestamps
    end
    add_index :goods, :name, unique: true
  end

  def down
    drop_table :goods
  end
end
