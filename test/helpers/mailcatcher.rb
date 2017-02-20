class MailCatcher
  include HTTParty

  base_uri 'http://127.0.0.1:1080'

  def clean
    self.class.delete('/messages')
  end

  def has_new_mail?
    fetch_messages.count > 0
  end

  def find_mail_with_subject(subject)
    messages = fetch_messages
    message = messages.find { |x| x['subject'] == subject }
    unless message.nil?
      fetch_message message['id']
    end
  end

  private

  def fetch_messages
    self.class.get('/messages')
  end

  def fetch_message(id)
    self.class.get("/messages/#{id}.html")
  end
end
