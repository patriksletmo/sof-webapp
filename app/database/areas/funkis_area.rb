module Areas
  module FunkisArea
    def funkis_categories
      get('/api/v1/funkis')
    end

    def create_funkis_application(params)
      options = {
          body: {
              item: params
          }
      }
      post('/api/v1/funkis_application', options.merge(authenticated_options))
    end

    def update_funkis_application(id, params)
      options = {
          body: {
              item: params
          }
      }
      put("/api/v1/funkis_application/#{id}", options.merge(authenticated_options))
    end

    def delete_funkis_application(id)
      delete("/api/v1/funkis_application/#{id}", authenticated_options)
    end

    def funkis_categories_stats
      get('/api/v1/funkis_application', authenticated_options)
    end
  end
end