module Areas
  module MenuArea
    def menu_items
      get('/api/v1/menu')
    end
  end
end