module CortegeHelper
  def readable_status
    case @cortege['status']
      when 'pending'
        'Väntar'
      else
        'Okänd'
    end
  end
end
