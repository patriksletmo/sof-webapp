module Areas
  module UserArea
    def all_users
      get('/api/v1/users', authenticated_options)
    end

    def single_user(id)
      get("/api/v1/users/#{id}", authenticated_options)
    end

    def update_user(id, params)
      options = {
        body: params
      }
      put("/api/v1/users/#{id}", options.merge(authenticated_options))
    end
  end
end