class UserMailer < ActionMailer::Base
  default from: "reply.to.experimentable@gmail.com"
  
  def welcome_email(user)
	@user = user
	mail(:to => user.email, :subject => "Welcome to Experimentable!")
  end
  
  def daily_email(user)
	@user = user
	@projects = user.projects
	@last_entry_date = user.entries.last.cal_date
	@latest_entries = user.entries.where("cal_date = ?", @last_entry_date)
	@current_date = Date.today
	mail(:to => user.email, :subject => "Reply with entries for #{@current_date}")
  end
	
  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password Reset")
  end
  
end
