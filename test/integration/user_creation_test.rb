require 'test_helper'

class UserCreationTest < ActionDispatch::IntegrationTest
  include EmailTester

  setup do
    email.clean
  end

  test 'visitors can create accounts and then login' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? '/login'

    click_link 'Registrering'

    fill_in 'Namn', with: 'Test Testsson'
    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'
    fill_in 'Upprepa lösenord', with: 'hunter2760'

    click_link 'Skapa användare'

    assert page.has_current_path? '/login'

    confirmation_email = email.find_mail_with_subject 'Confirmation instructions'
    assert_not_nil confirmation_email

    confirmation_link = find_link_in confirmation_email, with_title: 'Bekräfta e-postadress'
    assert_not_nil confirmation_link

    visit confirmation_link
    assert page.has_current_path? '/login'

    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'

    click_link 'login-button'

    assert page.has_current_path? '/profile'
    assert page.has_content? 'Test Testsson'
  end

  test 'visitors can login with liu id' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? '/login'

    click_link 'Logga in med LiU-ID'
    assert page.has_current_path? /https:\/\/login\.liu\.se\/cas\//, url: true
  end

end