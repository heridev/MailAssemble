ActionMailer::Base.smtp_settings = {
  :address   => "smtp.mandrillapp.com",
  :port      => 587,
  :user_name => ENV['MANDRILL_USERNAME'],
  :password  => ENV['MANDRILL_API_KEY'],
  :domain    => 'heroku.com'
}

ActionMailer::Base.delivery_method = :smtp

MandrillMailer.configure do |config|
  config.api_key = ENV['MANDRILL_API_KEY']
end
