require 'helpers/mailcatcher'

module EmailTester

  def email
    @email_service ||= MailCatcher.new
  end

end