module Areas
  module CortegeMembershipArea
    def cortege_memberships
      get('/api/v1/cortege_membership')
    end

    def create_cortege_membership(params)
      options = {
          body: params

      }
      post('/api/v1/cortege_membership', options.merge(authenticated_options))
    end

    def show_cortege_memberships(id)
      get("/api/v1/cortege_membership/cortege/#{id}", authenticated_options)
    end

    def show_case_cortege_memberships(id)
      get("/api/v1/cortege_membership/case_cortege/#{id}", authenticated_options)
    end

    def delete_cortege_membership(id)
      delete("/api/v1/cortege_membership/#{id}", authenticated_options)
    end
  end
end