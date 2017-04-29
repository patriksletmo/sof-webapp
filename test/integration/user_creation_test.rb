require 'test_helper'

class UserCreationTest < ActionDispatch::IntegrationTest
  include EmailSupportedTest

  LOGIN_URL_WITH_REDIRECT = /\/login\?redirect_url=/

  setup do
    inbox.clean
  end

  test 'visitors can create accounts and then login' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? LOGIN_URL_WITH_REDIRECT

    click_link 'Registrering'

    fill_in 'Namn', with: 'Test Testsson'
    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'
    fill_in 'Upprepa lösenord', with: 'hunter2760'

    click_link 'Skapa användare'

    confirmation_email = inbox.find_mail_with_subject 'SOF17 - Välkommen till StudentOrkesterFestivalen'
    assert_not_nil confirmation_email

    confirmation_link = find_link_in confirmation_email, with_title: 'Aktivera konto'
    assert_not_nil confirmation_link

    visit confirmation_link
    assert page.has_current_path? '/login'

    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'

    click_link 'login-button'

    assert page.has_current_path? '/'
    assert page.has_content? 'Konto'
  end

  test 'visitors can login with liu id' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? LOGIN_URL_WITH_REDIRECT

    click_link 'Logga in med LiU-ID'
    assert page.has_current_path? /https:\/\/login\.liu\.se\/cas\//, url: true
  end

end