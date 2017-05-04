class ApplicationController < ActionController::Base
  include AuthenticationConcern
  include DisplayNameConcern
  include InternationalizationConcern
  protect_from_forgery with: :exception


  def toast_response_message(response)
    if response.success?
      flash[:success] = response['message']
    else
      if response['message'].present?
        flash[:error] = response['message']
      else
        flash[:error] = 'Something went terribly wrong. Invalid response'
      end
    end
  end
end
