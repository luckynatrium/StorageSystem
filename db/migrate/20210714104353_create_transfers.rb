class CreateTransfers < ActiveRecord::Migration[6.1]
  def up
    create_table :transfers do |t|
      t.references :source,  foreign_key: {to_table: :storages}
      t.references :destination,  foreign_key: {to_table: :storages}
      t.references :good
      t.integer :quanity
      t.timestamps 
    end
    add_index :transfers, [:source_id, :destination_id]
    add_index :transfers, [:source_id, :destination_id, :good_id]
  end

  def down
    drop_index :transfers, [:source_id, :destination_id]
    drop_index :transfers, [:source_id, :destination_id, :good_id]
    drop_table :transfers
  end
end
