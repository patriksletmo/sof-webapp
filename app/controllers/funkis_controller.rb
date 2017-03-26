class FunkisController < NavigationController
  def index

  end

  def categories
    @categories = database.funkis_categories

    # Sort the funkis_shifts per day
    @categories.each do |category|
      days = Hash.new { |h, k| h[k] = [] }
      category['available_shifts'].each do |shift|
        if days.key?(shift['day'])
          days[shift['day']] << shift
        else
          days[shift['day']] = [shift]
        end
      end
      category['funkis_shifts'] = days
    end
  end

  def application

  end

  def new
    
  end
end
