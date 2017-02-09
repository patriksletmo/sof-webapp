class ApplicationController < ActionController::Base
  include AuthenticationConcern
  include InternationalizationConcern
  protect_from_forgery with: :exception
end
