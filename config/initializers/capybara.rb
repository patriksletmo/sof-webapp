if Rails.env.test?
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(
        app,
        browser: :firefox,
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.firefox(marionette: false)
    )
  end

  if ENV['TRAVIS'] == 'true'
    # Travis CI does not support Chrome driver out of the box.
    Capybara.default_driver = :selenium
  else
    Capybara.default_driver = :selenium_chrome
  end
end
