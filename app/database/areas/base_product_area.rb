module Areas
  module BaseProductArea
    def base_product_statistics
      get('/api/v1/base_product/statistics', authenticated_options)
    end
  end
end
