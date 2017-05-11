module Areas
  module OrderStatisticsArea
    def order_stats_summary(parameter, sum=false)
      get("/api/v1/order_stats?parameter=#{parameter}&sum=#{sum}", authenticated_options)
    end
  end
end