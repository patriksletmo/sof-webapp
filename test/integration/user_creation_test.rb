class UserCreationTest < ActionDispatch::IntegrationTest
=begin
  Disable UI tests until Travis CI integration is fixed

  setup do
    ApplicationController.any_instance.stubs(:database).returns(TestDatabase.new)
  end

  test 'visitors can create accounts' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? '/login'

    click_link 'register-button'
    assert page.has_current_path? '/register'

    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'
    fill_in 'Upprepa lösenord', with: 'hunter2760'

    click_link 'Skapa användare'

    assert page.has_current_path? '/login'
  end

  test 'visitors can login with liu id' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? '/login'

    click_link 'Logga in med LiU-ID'
    assert page.has_current_path? /https:\/\/login\.liu\.se\/cas\//, url: true
  end

  test 'visitors can login with a normal account' do
    visit '/'
    click_link 'Logga in'
    assert page.has_current_path? '/login'

    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'

    click_link 'login-button'
    assert page.has_current_path? '/profile'
  end

=end

end