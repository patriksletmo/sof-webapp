module Areas
  module FaqArea
    def faq
      get('/api/v1/faq')
    end

    def create_faq(params)
      options = {
          body: {
              item: params
          }
      }
      post('/api/v1/faq', options.merge(authenticated_options))
    end

    def show_faq(id)
      get("/api/v1/faq/#{id}", authenticated_options)
    end

    def update_faq(id, params)
      options = {
          body: {
              item: params
          }
      }
      put("/api/v1/faq/#{id}", options.merge(authenticated_options))
    end

    def destroy_faq(id)
      delete("/api/v1/faq/#{id}", authenticated_options)
    end
  end
end
