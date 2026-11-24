# Capybara resets a Chrome session by clearing storage for the "*" origin,
# and Chrome 158 rejects that as "* is not a valid URL", failing every
# browser spec. Clear every cookie instead, then the local storage of each
# origin the tab visited. This follows teamcapybara/capybara#2867. Delete
# this file once a Capybara release fixes issue 2865 upstream.
module CapybaraChromeReset
  private

  def execute_cdp(cmd, params = {})
    return super unless cmd == "Storage.clearDataForOrigin" &&
                        params[:origin] == "*"

    super("Network.clearBrowserCookies")
    return unless params[:storageTypes].include?("local_storage")

    visited_origins.each do |origin|
      super(cmd, origin: origin, storageTypes: "local_storage")
    end
  end

  def visited_origins
    execute_cdp("Page.getNavigationHistory")["entries"]
      .filter_map { |entry| origin_of(entry["url"]) }
      .uniq
  end

  def origin_of(url)
    uri = URI.parse(url.to_s)
    return unless %w[http https].include?(uri.scheme) && uri.host

    "#{uri.scheme}://#{uri.host}:#{uri.port}"
  rescue URI::InvalidURIError
    nil
  end
end

Capybara::Selenium::Driver::ChromeDriver.prepend(CapybaraChromeReset)
