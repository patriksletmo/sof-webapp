module Areas
  module OrderStatisticsArea
    def order_stats_summary(parameter, sum=false, date=nil)
      get("/api/v1/order_stats?parameter=#{parameter}&sum=#{sum}&date=#{date}", authenticated_options)
    end
  end
end