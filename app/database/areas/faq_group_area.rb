module Areas
  module FaqGroupArea
    def faq_group
      get('/api/v1/faq_group', authenticated_options)
    end

    def create_faq_group(params)
      options = {
          body: {
              item: params
          }
      }
      post('/api/v1/faq_group', options.merge(authenticated_options))
    end

    def show_faq_group(id)
      get("/api/v1/faq_group/#{id}", authenticated_options)
    end

    def destroy_faq_group(id)
      delete("/api/v1/faq_group/#{id}", authenticated_options)
    end
  end
end