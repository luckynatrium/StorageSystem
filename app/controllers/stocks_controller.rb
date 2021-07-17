class StocksController < ApplicationController
  include Queries::StocksQueries

  def index
    @storage_id = params[:storage_id]
    @stocks = get_stocks_with_delivery_date(@storage_id)
  end
end
