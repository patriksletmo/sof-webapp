# NOTE: This file is only reloaded when restarting the server
module HTTParty
  class Response
    STANDARD_ERROR = 'Ett oväntat fel inträffade'

    def friendly_error
      if key? 'errors'
        errors = self['errors']
        if errors.kind_of?(::Hash) and errors.key? 'full_messages'
          errors['full_messages'].first
        elsif errors.kind_of?(::Array)
          errors.first
        else
          STANDARD_ERROR
        end
      else
        STANDARD_ERROR
      end
    end
  end
end
