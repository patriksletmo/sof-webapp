class NavigationController < ApplicationController
  helper_method :menu_items

  protected

  def menu_items
    @active_menu_items ||= database.menu_items

    unless @active_menu_items.success?
      raise 'Unable to fetch menu items from database'
    end

    @active_menu_items
  end
end