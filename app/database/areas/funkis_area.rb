module Areas
  module FunkisArea
    def funkis_categories
      get('/api/v1/funkis/categories')
    end
  end
end