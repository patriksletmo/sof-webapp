module Areas
  module AccountArea
    def register(display_name, email, password, confirmation, success_url)
      options = {
        body: {
          display_name: display_name,
          email: email,
          password: password,
          password_confirmation: confirmation,
          confirm_success_url: success_url
        }
      }
      post('/api/v1/auth/', options)
    end

    def login(email, password)
      options = {
        body: {
          email: email,
          password: password
        }
      }
      post('/api/v1/auth/sign_in', options)
    end

    def request_password_reset(email, redirect_url)
      options = {
        body: {
          email: email,
          redirect_url: redirect_url
        }
      }
      post('/api/v1/auth/password', options)
    end

    def reset_password(new_password, confirmation)
      options = {
        body: {
          password: new_password,
          password_confirmation: confirmation
        }
      }
      put('/api/v1/auth/password', options.merge(authenticated_options))
    end

    def edit_password(current_password, new_password, confirmation)
      options = {
        :body => {
          #:current_password => current_password,
          :password => new_password,
          :password_confirmation => confirmation
        }
      }
      put('/api/v1/auth/password', options.merge(authenticated_options))
    end

    def logout
      delete('/api/v1/auth/sign_out', authenticated_options)
    end

    def current_user
      get('/api/v1/user', authenticated_options)
    end
  end
end