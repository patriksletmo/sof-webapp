module Areas
  module CaseCortegeArea
    def create_case_cortege(item_params)
      options = {
        body: item_params
      }
      post('/api/v1/case_cortege', options.merge(authenticated_options))
    end

    def show_case_cortege(id)
      get("/api/v1/case_cortege/#{id}", authenticated_options)
    end

    def update_case_cortege(id, item_params)
      options = {
        body: item_params
      }
      put("/api/v1/case_cortege/#{id}", options.merge(authenticated_options))
    end

    def delete_case_cortege(id)
      delete("/api/v1/case_cortege/#{id}", authenticated_options)
    end

    def all_case_corteges
      get('/api/v1/case_cortege', authenticated_options)
    end
  end
end