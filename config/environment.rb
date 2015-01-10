# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :domain         => 'subzie.com',
  :authentication => :plain,
  :address        => 'smtp.1and1.com',
  :port           => 587, # Also available: 80, 25, 465 (SSL)
  :user_name      => ENV['email_user_name'],
  :password       => ENV['email_password']
}
