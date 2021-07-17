module Queries
  module DeliveriesQueries
    include DeliveriesHelper

    def get_deliveries_grouped_by_date
      Delivery
      .all
      .preload(:good)
      .map {|delivery| delivery_to_view delivery}
      .group_by { |delivery| delivery[:date]}
    end
  end
end