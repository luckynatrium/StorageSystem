class Transfer < ApplicationRecord
  belongs_to :source_storage, class_name: 'Storage', foreign_key: :source_id
  belongs_to :destination_storage, class_name: 'Storage', foreign_key: :destination_id
  belongs_to :good

  scope :with_includes, -> {includes(:destination_storage, :source_storage, :good)}
end
