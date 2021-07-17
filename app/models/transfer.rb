class Transfer < ApplicationRecord
  belongs_to :source_storage, class_name: 'Storage', foreign_key: :source_id
  belongs_to :destination_storage, class_name: 'Storage', foreign_key: :destination_id
  belongs_to :good

  def self.create_transfers(src_storage_id, dest_storage_id, attrs)
    attrs[:quantity].to_h.each do |good_id, quantity|
      if quantity != ''
        Transfer.create!(
          {
           source_id: src_storage_id,
           destination_id: dest_storage_id,
           good_id: good_id, 
           quantity: quantity
           })
        src_stock = Stock.find_by storage_id: src_storage_id, good_id: good_id
        dest_stock = Stock.find_by storage_id: dest_storage_id, good_id: good_id
        if dest_stock.nil?
          Stock.create(storage_id: dest_storage_id, good_id: good_id, quantity: quantity)
        else
          Stock.transfer_stocks src_stock, dest_stock, quantity.to_i
        end
      end
    end
  end
end
