module Areas
  module CollectArea
    def search_for_user(query)
      get("/api/v1/collect/search?query=#{query}", authenticated_options)
    end

    def retrieve_user_with_items(user_id)
      get("/api/v1/collect/#{user_id}", authenticated_options)
    end

    def collect_user_items(user_id, collected_ids)
      options = {
          body: {
              collected_ids: collected_ids
          }
      }
      post("/api/v1/collect/#{user_id}", options.merge(authenticated_options))
    end
  end
end