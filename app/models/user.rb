class User < ActiveRecord::Base
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password
	before_create { generate_token(:auth_token) }
	
	has_many :entries, :dependent => :destroy
	has_many :projects, :dependent => :destroy
	
	validates  	:email,
				:presence 	=> true,
				:uniqueness => { :case_sensitive => false },
				:format 	=> { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
	
	validates	:name,
				:presence 	=> true,
				:length 	=> { :maximum => 50 }

	validates_presence_of :password, :on => :create 
	  
  
	def generate_token(column)
		begin
		  self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def self.send_daily_emails
		@users = User.all
		@users.each do |u|
			UserMailer.daily_email(u).deliver
			sleep 3
		end
	end
	
	def send_password_reset
	  generate_token(:password_reset_token)
	  self.password_reset_sent_at = Time.zone.now
	  save!
	  UserMailer.delay.password_reset(self)
	end


	
end
