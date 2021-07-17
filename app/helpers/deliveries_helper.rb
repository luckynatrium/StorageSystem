module DeliveriesHelper
  def delivery_to_view(delivery)
    {good: delivery.good.name, good_updated_at: delivery.good.updated_at, 
      date: delivery.date, quantity: delivery.quantity}
  end
end
