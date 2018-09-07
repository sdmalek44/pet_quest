# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
      {"provider"=>"google_oauth2",
       "uid"=>"100857051672230728041",
       "info"=>
        {"name"=>"Stephen Malek",
         "email"=>"malek.stephen44@gmail.com",
         "first_name"=>"Stephen",
         "last_name"=>"Malek",
         "image"=>"https://lh3.googleusercontent.com/-tQF1krYYNT8/AAAAAAAAAAI/AAAAAAAAAAA/APUIFaPAdtfOoAI7ZQ-KkaXIiwCm0M_T_Q/mo/photo.jpg",
         "urls"=>{"google"=>"https://plus.google.com/100857051672230728041"}},
         "credentials"=>
           {"token"=>"",
            "expires_at"=>1536353459,
            "expires"=>true}
          }
        }
      })
  end
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  VCR.configure do |config|
    config.cassette_library_dir = "spec/cassettes"
    config.hook_into :webmock
    config.allow_http_connections_when_no_cassette = true
    config.filter_sensitive_data('<key>') { ENV["GITHUB_TEST_KEY"] }
  end

  config.include FactoryBot::Syntax::Methods

  config.before(:each) do
    WebMock.reset!
  end

  config.before(:suite) do
   DatabaseCleaner.clean_with(:truncation)
   DatabaseCleaner.strategy = :truncation
  end

 config.around(:each) do |example|
   DatabaseCleaner.cleaning do
     example.run
   end
 end

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
