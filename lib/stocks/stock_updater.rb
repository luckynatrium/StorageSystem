module Stocks
  class StockUpdater

    def initialize(storage_id, good_id)
      @storage_id = storage_id
      @good_id = good_id
      @stock = Stock.find_by storage_id: storage_id, good_id: good_id
    end

    def increase_amount_or_create(quantity)
      if @stock.nil?
        @stock = Stock.create!(storage_id: @storage_id, good_id: @good_id, quantity: quantity)
      else
        @stock.change_quantity quantity
      end
    end

    def increase_amount(quantity)
      raise ActiveRecord::RecordNotFound.new message: "No such stock" if @stock.nil?
      @stock.change_quantity quantity
    end

    def decrease_amount(quantity)
      increase_amount -quantity
    end
  end
end