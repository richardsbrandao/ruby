ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => "587",
  :domain               => 'gmail.com',
  :user_name            => 'richardsbrandao@gmail.com',
  :password             => 'acmilan',
  :authentication       => 'plain',
  :enable_starttls_auto => true  }