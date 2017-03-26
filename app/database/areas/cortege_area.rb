module Areas
  module CortegeArea
    def create_cortege(item_params)
      options = {
        body: item_params
      }
      post('/api/v1/cortege', options.merge(authenticated_options))
    end

    def show_cortege(id)
      get("/api/v1/cortege/#{id}", authenticated_options)
    end

    def update_cortege(id, item_params)
      options = {
        body: item_params
      }
      put("/api/v1/cortege/#{id}", options.merge(authenticated_options))
    end

    def delete_cortege(id)
      delete("/api/v1/cortege/#{id}", authenticated_options)
    end

    def all_corteges
      get('/api/v1/cortege', authenticated_options)
    end
  end
end