class OrderStatisticsController < NavigationController
  def index
    date_from = '2017-05-01'
    date_to = Date.today.to_s

    @stats = database.order_stats_summary(date_from, date_to, params[:sum])
  end
end
