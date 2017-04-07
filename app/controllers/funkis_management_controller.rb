class FunkisManagementController < NavigationController
  def index
    return if require_login!

    @categories = database.funkis_categories_stats
    unless @categories.success?
      redirect_to '/'
    end
  end
end
