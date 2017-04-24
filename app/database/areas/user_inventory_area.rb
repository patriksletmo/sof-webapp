module Areas
  module UserInventoryArea
    def inventory
      get('/api/v1/order_item', authenticated_options)
    end

    def orders
      get('/api/v1/order', authenticated_options)
    end

    def order(order_id)
      get("/api/v1/order/#{order_id}", authenticated_options)
    end

    def order_item(order_item_id)
      get("/api/v1/order_item/#{order_item_id}", authenticated_options)
    end

    def gift_item(order_item_id, new_owner_email)
      options = {
          body: {
              item: {
                  owner: new_owner_email
              }
          }
      }
      put("/api/v1/order_item/#{order_item_id}", options.merge(authenticated_options))
    end
  end
end