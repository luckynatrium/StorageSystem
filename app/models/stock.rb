class Stock < ApplicationRecord
  belongs_to :good
  belongs_to :storage
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  def change_quantity(delta)
    self.quantity += delta
    puts self.quantity
    self.save!
  end

  def self.transfer_stocks(src_stock, dest_stock, quantity)
    src_stock.change_quantity -quantity
    dest_stock.change_quantity quantity
  end
end
