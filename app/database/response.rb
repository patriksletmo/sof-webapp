module HTTParty
  class Response < BasicObject

    # HTTParty response objects lack an easy way to check if the request succeeded,
    # thus we extend it with this functionality ourselves
    def success?
      response.code >= 200 && response.code <= 299
    end
  end
end
