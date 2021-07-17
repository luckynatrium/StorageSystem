class Stock < ApplicationRecord
  belongs_to :good
  belongs_to :storage
  validates :quantity, numericality: {greater_than: 0}

  def change_quantity(delta)
    self.quantity += delta
    if self.quantity == 0
      self.destroy
    else
      self.save!
    end
  end

end
