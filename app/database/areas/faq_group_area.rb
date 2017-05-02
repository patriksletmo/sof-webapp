module Areas
  module FaqGroupArea
    def faq_group
      get('/api/v1/faq_group')
    end

    def create_faq_post(params)
      options = {
          body: {
              item: params
          }
      }
      post('/api/v1/faq_group', options.merge(authenticated_options))
    end
  end
end