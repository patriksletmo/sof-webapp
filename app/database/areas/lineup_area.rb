module Areas
  module LineupArea
    def create_lineup(item_params)
      options = {
        body: item_params
      }
      post('/api/v1/lineups', options.merge(authenticated_options))
    end

    def show_lineup(id)
      get("/api/v1/lineups/#{id}", authenticated_options)
    end

    def update_lineup(id, item_params)
      options = {
        body: item_params
      }
      put("/api/v1/lineups/#{id}", options.merge(authenticated_options))
    end

    def delete_cortege_lineup(id)
      delete("/api/v1/lineups/#{id}", authenticated_options)
    end

    def all_lineups
      get('/api/v1/lineups', authenticated_options)
    end

    def get_orchestras_from_lineups
      get('/api/v1/lineups/artists_from_lineups', authenticated_options)
    end

    def get_corteges_from_lineups
      get('/api/v1/lineups/corteges_from_lineups', authenticated_options)
    end
  end
end