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
        flash[:error] = 'Något gick väldigt fel, fick ett ogiltigt svar av servern.'
      end
    end
  end
end
