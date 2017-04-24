# Synthetic response for requests that failed
class FailedResponse < BasicObject
  def success?
    false
  end

  def friendly_error
    'Kunde inte ansluta till databasen'
  end

  def body!
    nil
  end

  def code
    -1
  end
end