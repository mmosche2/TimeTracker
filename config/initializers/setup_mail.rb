require "#{Rails.root}/app/mailers/user_mailer"

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "mail.gmail.com",
  :user_name            => "reply.to.experimentable@gmail.com",
  :password             => "questrial1",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
