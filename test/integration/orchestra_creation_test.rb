require 'test_helper'

class OrchestraCreationTest < ActionDispatch::IntegrationTest
  setup do
    AccountHelper.use_test_account
  end

  test 'users can create orchestras' do
    visit '/orchestra/create'

    fill_in 'Orkesternamn', with: 'Testorkester'
    choose 'Orkester + Balett'
    click_button 'Skapa orkester'

    assert page.has_current_path? /\/orchestra\/[0-9]+/

    assert_equal 'Testorkester', page.find_field('Orkesternamn').value
    assert page.has_checked_field? 'Orkester + Balett', visible: :all
    assert page.has_checked_field? 'Ja', visible: :all
  end
end