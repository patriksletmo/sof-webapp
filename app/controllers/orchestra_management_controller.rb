class OrchestraManagementController < NavigationController
  def index
    return if require_login!

    @orchestras = database.all_orchestras
    unless @orchestras.success?
      render status: 403
    end
  end
end
