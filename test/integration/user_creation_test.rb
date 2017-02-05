class UserCreationTest < ActionDispatch::IntegrationTest
  setup do
    ApplicationController.any_instance.stubs(:database).returns(TestDatabase.new)
  end

  test 'visitors can create accounts' do
    visit '/'
    click_link 'Logga in'
    assert_equal '/login', current_path

    click_link 'register-button'
    assert_equal '/register', current_path

    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'
    fill_in 'Upprepa lösenord', with: 'hunter2760'

    click_link 'Skapa användare'

    assert_equal '/login', current_path
  end

  test 'visitors can login with liu id' do
    visit '/'
    click_link 'Logga in'
    assert_equal '/login', current_path

    click_link 'Logga in med LiU-ID'
    assert_equal '/login/liu_id', current_path
  end

  test 'visitors can login with a normal account' do
    visit '/'
    click_link 'Logga in'
    assert_equal '/login', current_path

    fill_in 'E-mail', with: 'test@sof17.se'
    fill_in 'Lösenord', with: 'hunter2760'

    click_link 'login-button'
    assert_equal '/profile', current_path
  end

end