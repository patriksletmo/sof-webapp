module Areas
  module OrchestraArea
    def create_orchestra(item_params)
      options = {
          body: item_params
      }
      post('/api/v1/orchestra', options.merge(authenticated_options))
    end

    def show_orchestra(id)
      get("/api/v1/orchestra/#{id}", authenticated_options)
    end

    def create_orchestra_signup(item_params)
      options = {
          body: item_params
      }
      post('/api/v1/orchestra_signup', options.merge(authenticated_options))
    end

    def show_orchestra_signup(id)
      get("/api/v1/orchestra_signup/#{id}", authenticated_options)
    end
  end
end