class CortegeManagementController < NavigationController
  def index
    return if require_login!

    @corteges = database.all_corteges
    unless @corteges.success?
      render status: 403
    end
  end
end
