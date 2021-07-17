class DeliveriesController < ApplicationController
  include DateHelper
  include Queries::DeliveriesQueries
  include Deliveries

  def index
    @deliveries = get_deliveries_grouped_by_date
    @goods = Good.all
  end

  def new
    @delivery = Delivery.new
    @goods = Good.all
  end

  def create
    if DeliveriesCreator.new(delivery_params).create 
      redirect_to action: "index"
    else 
      redirect_to new_storage_delivery_url, notice: exception.message
    end
  end

  private

  def delivery_params
    storage_id = params.require(:storage_id)
    attrs = params.require(:delivery)
    .permit("delivery_date(1i)", "delivery_date(2i)", "delivery_date(3i)", :quantity => {})
    
    {storage_id: storage_id, quantity: attrs[:quantity], 
      date: extract_selected_date("delivery_date", attrs)}
  end
end
