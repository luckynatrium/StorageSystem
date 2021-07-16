require 'date'
class Delivery < ApplicationRecord
  belongs_to :storage
  belongs_to :good

  def self.create_deliveries(storage_id, attrs)
    attrs[:quantity].to_h.each do |good_id, quantity|
      if quantity != ''
        Delivery.create(
          {storage_id: storage_id, 
           good_id: good_id, 
           quantity: quantity,
           date: concat_delivery_date(attrs) 
           })
        
        stock = Stock.find_by storage_id: storage_id, good_id: good_id
        if stock.nil?
          Stock.create(storage_id: storage_id, good_id: good_id, quantity: quantity)
        else
          stock.change_quantity quantity.to_i
        end
      end
    end
  end

  def to_view
    {good: good.name, good_updated_at: good.updated_at, date: date, quantity: quantity}
  end

  private 

  def self.concat_delivery_date(attrs)
    DateTime.strptime(attrs.values_at("delivery_date(1i)", "delivery_date(2i)", "delivery_date(3i)") * "-",
    '%Y-%m-%d')
  end
end
