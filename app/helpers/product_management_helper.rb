module ProductManagementHelper
  def percent_of(numerator, denominator)
    unless denominator.zero?
       (numerator.to_f / denominator.to_f * 100).round(1)
    end
  end
end