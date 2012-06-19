class UserMailer < ActionMailer::Base
  default from: "reply.to.experimentable@gmail.com"
  
  def welcome_email(user)
	@user = user
	mail(:to => user.email, :subject => "Welcome to Experimentable!")
  end
  
  def daily_email(user)
	@user = user
	mail(:to => user.email, :subject => "What did you do today?")
  end
	
  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password Reset")
  end
  
end
