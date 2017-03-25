class ApplicationController < ActionController::Base
  include AuthenticationConcern
  include DisplayNameConcern
  include InternationalizationConcern
  protect_from_forgery with: :exception
end
