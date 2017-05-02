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
  end
end