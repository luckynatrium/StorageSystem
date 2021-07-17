module Queries
  module TransfersQueries
    
    def get_transfer_group_by_storages
      Transfer
      .with_includes
      .group_by { |transfer| [transfer.source_storage.name, transfer.destination_storage.name]}
    end
  end
end