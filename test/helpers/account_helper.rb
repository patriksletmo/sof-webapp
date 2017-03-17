class AccountHelper
  extend ShowMeTheCookies

  NAME = 'SOF-Putte'
  EMAIL = 'testputte@sof17.se'
  PASSWORD = SecureRandom.hex
  DUMMY_URL = 'https://sof17.se'

  AUTHENTICATION_COOKIES = {}

  # Sets up a test account and prepares authentication cookies
  def self.create_test_account
    register_account
    confirm_email
    store_authentication_cookies
  end

  # Applies authentication cookies to Capybara session
  # Runtime requirements:
  #  - A test account has been created using create_test_account
  #  - Capybara is currently showing an url from the webpage to test
  def self.use_test_account
    expire_cookies
    AUTHENTICATION_COOKIES.each do |key, value|
      create_cookie(key, value)
    end
  end

  private

  def self.register_account
    Database.anonymous.register(
        NAME,
        EMAIL,
        PASSWORD,
        PASSWORD,
        DUMMY_URL
    )
  end

  def self.confirm_email
    confirmation_email = MailCatcher.new.find_mail_with_subject 'Confirmation instructions'
    confirmation_link = find_link_in confirmation_email, with_title: 'Bekräfta e-postadress'

    Net::HTTP.get(URI(confirmation_link))
  end

  def self.store_authentication_cookies
    response = Database.anonymous.login(EMAIL, PASSWORD)

    AUTHENTICATION_COOKIES[:auth_token] = response.headers['access-token']
    AUTHENTICATION_COOKIES[:client_id] = response.headers['client']
    AUTHENTICATION_COOKIES[:expiry] = response.headers['expiry']
    AUTHENTICATION_COOKIES[:uid] = response.headers['uid']
  end
end