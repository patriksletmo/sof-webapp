module Areas
  module CortegeLineupArea
    def create_cortege_lineup(item_params)
      options = {
        body: item_params
      }
      post('/api/v1/cortege_lineups', options.merge(authenticated_options))
    end

    def show_cortege_lineup(id)
      get("/api/v1/cortege_lineups/#{id}", authenticated_options)
    end

    def update_cortege_lineup(id, item_params)
      options = {
        body: item_params
      }
      put("/api/v1/cortege_lineups/#{id}", options.merge(authenticated_options))
    end

    def delete_cortege_lineup(id)
      delete("/api/v1/cortege_lineups/#{id}", authenticated_options)
    end

    def all_corteges_lineups
      get('/api/v1/cortege_lineups', authenticated_options)
    end

    def get_orchestras_from_lineups
      get('/api/v1/cortege_lineups/artists_from_lineups', authenticated_options)
    end

    def get_corteges_from_lineups
      get('/api/v1/cortege_lineups/corteges_from_lineups', authenticated_options)
    end
  end
end