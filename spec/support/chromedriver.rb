require "selenium/webdriver"

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new
  options.add_argument "--window-size=1680,1050"
  # Nothing outside the application under test should answer the browser.
  # Without this the pages fetch Google Maps, and product photos from S3.
  options.add_argument(
    "--host-resolver-rules=MAP * ~NOTFOUND, EXCLUDE localhost, " \
    "EXCLUDE 127.0.0.1",
  )
  options.headless!

  # Selenium 4 takes the browser options under :capabilities. Passing them as
  # :options still works, but is deprecated.
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: options,
  )
end

Capybara.javascript_driver = :headless_chrome

# Requiring webdrivers hands Selenium a proc that fetches a driver before every
# run. A machine that already has a chromedriver should use that one instead,
# because it was installed next to the Chrome it has to drive.
module ChromedriverBinary
  def self.path
    @path ||= installed_path || downloaded_path
  end

  def self.installed_path
    ENV["PATH"].to_s.split(File::PATH_SEPARATOR).
      map { |directory| File.join(directory, "chromedriver") }.
      find { |candidate| File.executable?(candidate) }
  end

  # Fetching a driver is a download, not traffic the application makes, so it
  # has to happen outside VCR and WebMock.
  def self.downloaded_path
    begin
      WebMock.allow_net_connect!
      path = VCR.turned_off { Webdrivers::Chromedriver.update }
    ensure
      WebMock.disable_net_connect!(allow_localhost: true)
    end

    path
  end
end

RSpec.configure do |config|
  config.before(:each, js: true) do
    ::Selenium::WebDriver::Chrome::Service.driver_path = ChromedriverBinary.path
  end
end
