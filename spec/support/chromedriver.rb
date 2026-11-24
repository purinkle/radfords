require "selenium/webdriver"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument "--window-size=1680,1050"
  # Nothing outside the application under test should answer the browser.
  # Without this the pages fetch Google Maps, and product photos from S3.
  options.add_argument(
    "--host-resolver-rules=MAP * ~NOTFOUND, EXCLUDE localhost, " \
    "EXCLUDE 127.0.0.1"
  )
  options.add_argument "--headless=new"

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :headless_chrome

# Selenium Manager, part of selenium-webdriver, finds the chromedriver that
# matches the installed Chrome, or fetches one, so nothing here picks a path.
