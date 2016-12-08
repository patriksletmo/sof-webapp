class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_menu_items
  helper_method :menu_items

  protected
  def menu_items
    @active_menu_items
  end

  def load_menu_items
    @active_menu_items ||= HTTParty.get("#{Rails.configuration.database_api_url}/api/v1/menu")

    status_code = @active_menu_items.code
    unless status_code >= 200 and status_code <= 299
      raise 'Unable to fetch menu items from database'
    end
  end
end
