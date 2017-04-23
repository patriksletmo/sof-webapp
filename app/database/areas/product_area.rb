module Areas
  module ProductArea
    def products(all: true)
      if all
        get('/api/v1/shopping_product', authenticated_options)
      else
        options = {
            body: {
                limit_items: true
            }
        }
        get('/api/v1/shopping_product', options.merge(authenticated_options))
      end
    end

    def get_product(id)
      get("/api/v1/shopping_product/#{id}", authenticated_options)
    end

    def create_product(item_params)
      options = {
          body: item_params
      }
      post('/api/v1/shopping_product', options.merge(authenticated_options))
    end

    def update_product(id, item_params)
      options = {
          body: item_params
      }
      put("/api/v1/shopping_product/#{id}", options.merge(authenticated_options))
    end
  end
end