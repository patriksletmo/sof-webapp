module Areas
  module FunkisArea
    def funkis_categories
      get('/api/v1/funkis')
    end
  end
end