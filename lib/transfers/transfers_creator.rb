module Transfers
  class TransfersCreator
    include Stocks

    def initialize(attrs)
      @goods_quantities = attrs[:quantity].to_h
      @src_storage_id = attrs[:src_storage_id]
      @dest_storage_id = attrs[:dest_storage_id]
    end

    def create
      begin
        Transfer.transaction do
          @goods_quantities.each do |good_id, quantity|
            process(good_id, quantity) unless quantity == ''
          end
        end
        true
      rescue ActiveRecord::RecordInvalid => exception
        puts exception.message
        false
      end
    end

    private

    def process(good_id, quantity)
      Transfer.create!(
        {
        source_id: @src_storage_id,
        destination_id: @dest_storage_id,
        good_id: good_id, 
        quantity: quantity
        })
        
      StockUpdater.new(@dest_storage_id, good_id).increase_amount_or_create(quantity.to_i)
      StockUpdater.new(@src_storage_id, good_id).decrease_amount(quantity.to_i)
    end
  end
end