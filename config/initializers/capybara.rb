if Rails.env.test?
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  # Materialize hides input elements and replaces them with input tags, this requires setting the following property
  Capybara.automatic_label_click = true

  if ENV['TRAVIS'] == 'true'
    # Travis CI does not support Chrome driver out of the box.
    Capybara.default_driver = :selenium
  else
    Capybara.default_driver = :selenium_chrome
  end
end
