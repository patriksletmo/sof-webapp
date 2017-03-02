module Areas
  module ProductArea
    def enabled_products
      get('/api/v1/shopping_product', {})
    end

    def get_product(id)
      get("/api/v1/shopping_product/#{id}", {})
    end
  end
end