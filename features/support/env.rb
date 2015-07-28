require 'cucumber/rails'

require 'capybara/cucumber'
require 'rspec/rails'
require 'capybara/poltergeist'
require 'paper_trail/frameworks/cucumber'

module Cucumber
  module Rails
    class World
      include FactoryGirl::Syntax::Methods
    end
  end
end

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :truncation
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Capybara.default_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: false,
    timeout: 120,
    debug: false,
    phantomjs_options: ['--load-images=no', '--disk-cache=false'],
    inspector: true
  }

  Capybara::Poltergeist::Driver.new(app, options)
end

AfterStep do
  page.save_screenshot 'scr.png'
end
