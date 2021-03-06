class CreateTransfers < ActiveRecord::Migration[6.1]
  def up
    create_table :transfers do |t|
      t.references :source,  foreign_key: {to_table: :storages}
      t.references :destination,  foreign_key: {to_table: :storages}
      t.references :good
      t.integer :quantity
      t.timestamps 
    end
    add_index :transfers, [:source_id, :destination_id]
    add_index :transfers, [:source_id, :destination_id, :good_id]
  end

  def down
    remove_index :transfers, column: [:source_id, :destination_id]
    remove_index :transfers, column: [:source_id, :destination_id, :good_id]
    drop_table :transfers
  end
end
