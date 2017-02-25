require 'helpers/mailcatcher'

module EmailSupportedTest

  def inbox
    @email_service ||= MailCatcher.new
  end

end