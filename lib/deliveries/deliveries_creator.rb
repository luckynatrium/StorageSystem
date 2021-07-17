module Deliveries
  class DeliveriesCreator
    include Stocks
    def initialize(attrs)
      @goods_quantities = attrs[:quantity].to_h
      @storage_id = attrs[:storage_id]
      @date = attrs[:date]
    end

    def create
      begin
        Delivery.transaction do
          @goods_quantities.each do |good_id, quantity|
            process(good_id, quantity) unless quantity == ''
          end
        end
        true
      rescue ActiveRecord::RecordInvalid => exception
        false
      end
    end

    private

    def process(good_id, quantity)
      Delivery.create!(
        {
        storage_id: @storage_id, 
        good_id: good_id, 
        quantity: quantity,
        date: @date
        })
        
      StockUpdater.new(@storage_id, good_id).increase_amount_or_create(quantity.to_i)
    end
  end
end