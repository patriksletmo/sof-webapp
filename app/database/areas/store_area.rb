module Areas
  module StoreArea
    def charge(stripe_token)
      options = {
          body: {stripe_token: stripe_token}
      }
      post('/api/v1/store/charge', options.merge(authenticated_options))
    end
  end
end