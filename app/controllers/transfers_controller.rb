class TransfersController < ApplicationController
  include Queries::TransfersQueries
  include Queries::StocksQueries
  include Transfers
  def index
    @transfers = get_transfer_group_by_storages 
  end

  def choose
    @storages = Storage.all
  end

  def new
    @transfer = Transfer.new
    @src_storage_id = params[:source_storage]
    @dest_storage_id = params[:dest_storage]
    @stocks_quantities = get_storages_stocks @src_storage_id, @dest_storage_id
  end

  def create
    if TransfersCreator.new(transfer_params).create
      redirect_to action: "index"
    else
      redirect_to transfers_choose_url, notice: "A error has occured while creating transfer"
    end
  end

  private

  def transfer_params
    attrs = 
    params
    .require(:transfer)
    .permit(:quantity => {})
    
    {
      quantity: attrs[:quantity], 
      src_storage_id: params[:src_storage_id], 
      dest_storage_id: params[:dest_storage_id]
    }
  end
end
