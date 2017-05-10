module Areas
  module OrderStatisticsArea
    def order_stats_summary(date_from=nil, date_to=nil, sum=false)
      if date_from.present?
        if date_to.nil?
          date_to = date_from
        end

        if sum
          sum_param = '&sum=true'
        else
          sum_param = nil
        end

        get("/api/v1/order_stats?from=#{date_from}&to=#{date_to}#{sum_param}", authenticated_options)
      else
        get('/api/v1/order_stats', authenticated_options)
      end
    end

  end
end