# Synthetic response for requests that failed
class FailedResponse < BasicObject
  def success?
    false
  end
end