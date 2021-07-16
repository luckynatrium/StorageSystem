class StoragesController < ApplicationController

  def index
    @storages = Storage.all
  end
  def new
    @storage = Storage.new
  end

  def create
    begin
      if Storage.create storage_params
        redirect_to storages_url, notice: "Storage was successfully created"
      else
        redirect_to new_storage_url, notice: "Storage wasn't created!!!!"
      end
    rescue ActiveRecord::RecordNotUnique
      redirect_to new_storage_url, notice: "Storage with exactly the same name is already in database"
    end
  end

  private 
  def storage_params
    params.require(:storage).permit(:name, :region)
  end
end
