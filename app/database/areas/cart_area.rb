module Areas
  module CartArea
    def get_cart
      get('/api/v1/cart', authenticated_options)
    end

    def add_item_to_cart(item)
      options = {
          body: {item: item}
      }

      put('/api/v1/cart/item', options.merge(authenticated_options))
    end

    def remove_item_from_cart(id)
      delete("/api/v1/cart/item/#{id}", authenticated_options)
    end

    def clear_cart
      delete('/api/v1/cart', authenticated_options)
    end
  end
end