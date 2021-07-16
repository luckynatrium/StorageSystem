class StocksController < ApplicationController

  def index
    @stocks = Stock.joins(
      "INNER JOIN deliveries 
      ON deliveries.storage_id = stocks.storage_id 
      AND deliveries.good_id = stocks.good_id")
      .joins("JOIN goods ON stocks.good_id = goods.id")
      .group(:quantity, :name)
      .where(storage_id: params[:storage_id])
      .select(:quantity, :name, "max(deliveries.date) as date")
  end
end
