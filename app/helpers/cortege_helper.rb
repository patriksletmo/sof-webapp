module CortegeHelper
  def cortege_status
    readable_status @cortege['status']
  end

  def cortege_type
    readable_type @cortege['cortege_type']
  end

  def readable_status(status)
    case status
      when 'pending'
        'Väntar'
      when 'in-review'
        'Granskning pågår'
      when 'done'
        'Beslut fattat'
      else
        'Okänd'
    end
  end

  def readable_type(type)
    case type
      when 0
        'Makro'
      when 1
        'Mikro'
      when 2
        'Fribygge'
      when 3
        'Casekårtege'
      else
        'Okänd'
    end
  end

  def status_option(status)
    content_tag :option, value: status, selected: (@cortege['status'] == status) do
      readable_status status
    end
  end
end
