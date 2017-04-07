module FunkisManagementHelper
  def sum_funkis_field_in(category, field)
    category['funkis_shifts'].sum { |x| x[field] }
  end
end
