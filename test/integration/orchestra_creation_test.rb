require 'test_helper'

class OrchestraCreationTest < ActionDispatch::IntegrationTest
  setup do
    AccountHelper.use_test_account
  end

  test 'users can create orchestras and sign up for them' do
    visit '/orchestra/create'

    fill_in 'Orkesternamn', with: 'Testorkester'
    choose 'Orkester + Balett'
    click_button 'Skapa orkester'

    assert page.has_current_path? /\/orchestra\/[0-9]+/

    assert_equal 'Testorkester', page.find_field('Orkesternamn').value
    assert page.has_checked_field? 'Orkester + Balett', visible: :all
    assert page.has_checked_field? 'Ja', visible: :all

    code = page.find('h4', text: /Kod:/).text[5..-1]

    open_menu 'Orkester'
    click_link 'Anmälan'

    assert page.has_current_path? '/orchestra/register'

    fill_in 'Orkesterkod', with: code

    assert page.has_content? 'Din kod är giltig och tillhör Testorkester'
  end
end