class Stock < ApplicationRecord
  belongs_to :good
  belongs_to :storage
  validates :quantity, numericality: {greater_than_or_equal_to: 0}

  def change_quantity(delta)
    self.quantity += delta
    self.save!
  end
end
