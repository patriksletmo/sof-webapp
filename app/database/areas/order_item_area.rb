module Areas
  module OrderItemArea
    def all_order_items
      get('/api/v1/order_item/all_items', authenticated_options)
    end
  end
end
