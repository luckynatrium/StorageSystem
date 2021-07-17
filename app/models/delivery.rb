class Delivery < ApplicationRecord
  belongs_to :storage
  belongs_to :good
end
