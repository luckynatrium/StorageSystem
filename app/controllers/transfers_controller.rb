class TransfersController < ApplicationController

  def index
    @transfers = Transfer.all.includes(:destination_storage, :source_storage, :good)
    .group_by { |transfer| [transfer.source_storage.name, transfer.destination_storage.name]}
  end

  def choose
    @storages = Storage.all
  end

  def new
    @transfer = Transfer.new
    @src_storage_id = params[:source_storage]
    @dest_storage_id = params[:dest_storage]
    @stocks_with_quantities = Stock.where(storage_id: params[:source_storage])
    .joins("LEFT JOIN stocks stk ON stk.good_id = stocks.good_id AND stk.storage_id =#{@dest_storage_id}")
    .joins(:good)
    .select('goods.id as good_id, goods.name as good_name, stocks.quantity as src_quantity, stk.quantity as dest_quantity')
  end

  def create
    begin
      Transfer.transaction do
        Transfer.create_transfers params[:src_storage_id], params[:dest_storage_id], transfer_params
      end
      redirect_to action: "index"
    rescue ActiveRecord::RecordInvalid => exception
      redirect_to new_storage_delivery_url, notice: exception.message
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:src_storage_id, :dest_storage_id, :quantity => {})
  end
end
