class CreateGood < ActiveRecord::Migration[6.1]
  def up
    create_table :goods do |t|
      t.string :name, :unique
      t.timestamps
    end
  end

  def down
    drop_table :goods
  end
end
