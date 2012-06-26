class UserMailer < ActionMailer::Base
  default from: "reply.to.experimentable@gmail.com"
  
  def welcome_email(user)
	@user = user
	@url = "http://pure-leaf-4813.herokuapp.com/"
	mail(:to => user.email, :subject => "Welcome to Experimentable!")
  end
  
  def daily_email(user)
	@user = user
	@projects = user.projects
	if (user.entries.last) 
		@last_entry_date = user.entries.last.cal_date
		@latest_entries = user.entries.where("cal_date = ?", @last_entry_date)
	else
		@last_entry_date = ""
		@latest_entries = ""
	end
	@current_date = Date.today
	mail(:to => user.email, :subject => "Reply with entries for #{@current_date.strftime('%a, %b %d')}")
  end
	
  def password_reset(user)
    @user = user
    mail(:to => user.email, :subject => "Password Reset")
  end
  
end
