class OrderStatisticsController < NavigationController
  def index
    return if require_login!

    @stats = database.order_stats_summary(params[:parameter], params[:sum], params[:date])
    unless @stats.success?
      redirect_to '/'
    end
  end
end
