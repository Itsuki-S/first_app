RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    if ENV["SELENIUM_DRIVER_URL"].present?
      driven_by :selenium, using: :chrome, options: {
        browser: :remote,
        url: ENV.fetch("SELENIUM_DRIVER_URL"),
        desired_capabilities: :chrome
      }
    else
      driven_by :selenium_chrome_headless, screen_size: [1280, 800], options: {
           browser: :chrome
        } do |driver_option|

            # Chrome オプション追加設定
            driver_option.add_argument('disable-notifications') 
            driver_option.add_argument('disable-translate')
            driver_option.add_argument('disable-extensions')
            driver_option.add_argument('disable-infobars')
            driver_option.add_argument('disable-gpu')
            driver_option.add_argument('no-sandbox')
            driver_option.add_argument('headless')
        end
    end
  end
end
