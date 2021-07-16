class CreateDelivery < ActiveRecord::Migration[6.1]
  def up
    create_table :deliveries do |t|
      t.references :storage
      t.references :good
      t.datetime :date
      t.integer :quantity
      t.timestamps
    end
    add_index :deliveries, [:storage_id, :good_id]
  end

  def down
    remove_index :deliveries, column: [:storage_id, :good_id]
    drop_table :deliveries
  end
end
