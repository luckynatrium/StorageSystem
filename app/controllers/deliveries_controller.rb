class DeliveriesController < ApplicationController

  def index
    @deliveries = Delivery.all.preload(:good).map {|delivery| delivery.to_view}
    .group_by { |delivery| delivery[:date]}
    @goods = Good.all
  end

  def new
    @delivery = Delivery.new
    @goods = Good.all
  end

  def create
    attrs = delivery_params
    begin
      Delivery.transaction do
        Delivery.create_deliveries @storage_id, attrs
      end
      redirect_to action: "index"
    rescue ActiveRecord::RecordInvalid => exception
      redirect_to new_storage_delivery_url, notice: exception.message
    end
  end

  private

  def delivery_params
    @storage_id = params.require(:storage_id)
    params.require(:delivery).permit(:good_id, :storage_id,
       "delivery_date(1i)", "delivery_date(2i)", "delivery_date(3i)", :quantity => {})
  end
end
