class GoodsController < ApplicationController

  def index
    @goods = Good.all
  end

  def new
    @good = Good.new
  end

  def edit
    @good = Good.find params[:id]
  end

  def create
    begin
      if Good.create good_params
        redirect_to goods_url, notice: "Good was successfully created"
      else
        redirect_to new_good_url, notice: "Good wasn't created!!!!"
      end
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = "Good with exactly the same name is already in database"
    end
  end

  def update
    @good = Good.find params[:id]
    begin
      if @good.update! good_params
        redirect_to goods_url, notice: "Good was successfully updated"
      else
        redirect_to edit_good_url(@good), notice: "Good wasn't updated!!!!"
      end
    rescue ActiveRecord::RecordNotUnique
      redirect_to edit_good_url(@good), notice: "Good with exactly the same name is already in database"
    end
  end
  
  def destroy
    @good = Good.find params[:id]
    if @good.destroy
      redirect_to goods_url, notice: "Good was successfully deleted"
    else
      redirect_to goods_url, notice: "A error has occur while deleting good"
    end
    
  end

private
  def good_params
    params.require(:good).permit(:name)
  end
end
