class NavigationController < ApplicationController
  helper_method :menu_items

  protected

  def menu_items
    @active_menu_items ||= database.menu_items
  end
end