class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.references :storage, foreign_key: {to_table: :storages}
      t.references :good, foreign_key: {to_table: :goods}
      t.integer :quantity
      t.timestamps
    end
  end

  def down
    drop_index(:stocks, :storage_id)
    drop_index(:stocks, :good_id)
    drop_table :stocks
  end
end
