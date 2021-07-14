class StoragesController < ApplicationController

  def index
    @storages = Storage.all
  end
  def new
    @storage = Storage.new
  end

  def create
    @storage = Storage.new(storage_params)
    begin
      if @storage.save!
        flash.now[:notice] =  "Storage was successfully created"
      else
        flash.now[:alert] = "Storage wasn't created!!!!"
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = "Storage with exactly the same name is already in database"
    end
  end

  private 
  def storage_params
    params.require(:storage).permit(:name, :region)
  end
end
