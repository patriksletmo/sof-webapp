module OrchestraHelper
  def human_instrument_size(size)
    case size
      when 1
        t('orchestra.register.instrument_size_very_small')
      when 2
        t('orchestra.register.instrument_size_small')
      when 3
        t('orchestra.register.instrument_size_medium')
      when 4
        t('orchestra.register.instrument_size_large')
      else
        t('orchestra.register.instrument_size_none')
    end
  end
end
