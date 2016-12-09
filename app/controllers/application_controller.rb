class ApplicationController < ActionController::Base
  include Session
  protect_from_forgery with: :exception
end
