module Queries
  module StocksQueries
    def get_storages_stocks(src_storage_id, dest_storage_id)
      Stock
      .where(storage_id: src_storage_id)
      .joins("LEFT JOIN stocks stk ON stk.good_id = stocks.good_id AND stk.storage_id = #{dest_storage_id}")
      .joins(:good)
      .select('goods.id as good_id, goods.name as good_name, stocks.quantity as src_quantity, stk.quantity as dest_quantity')
    end

    def get_stocks_with_delivery_date(storage_id)
      Stock
        .joins(
          "INNER JOIN deliveries 
          ON deliveries.storage_id = stocks.storage_id 
          AND deliveries.good_id = stocks.good_id")
        .joins("JOIN goods ON stocks.good_id = goods.id")
        .group(:quantity, :name)
        .where(storage_id: storage_id)
        .select(:quantity, :name, "max(deliveries.date) as date") 
    end
  end
end