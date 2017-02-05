if Rails.env.test?
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end

  Capybara.default_driver = :selenium_chrome
end
