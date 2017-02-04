module Areas
  module MenuArea
    def menu_items
      get('/api/v1/menu', authenticated_options)
    end
  end
end