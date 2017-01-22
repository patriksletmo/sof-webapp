class PagesController < NavigationController
  def index
    @page = Database.new(token).page(params[:category], params[:page])

    unless @page.success?
      render nothing: true, status: 404
    end
  end
end
