class Entry < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :project

	def self.receive_mail(message)
	  user = User.find_by_email(message.from.first)
	  if !user.nil?
	    #email address is recognized in db
		if message.multipart?
			message_body = message.parts[0].body.decoded
			
			#check for a reply from gmail
			regex_gmailreply = /On.*<reply.to.experimentable@gmail.com>/
			if (message_body.match(regex_gmailreply))
				#Get the calendar date from the reply from gmail line
				r = message_body.slice(regex_gmailreply)
				r = r.slice(/(?<month>\w{3}) (?<day>\d{1,2}), (?<year>\d{4})/)
				puts "calendar_date: " + r
				#month is in "Apr" format, so convert to number
				month = r[$1] 
				month = Date::ABBR_MONTHNAMES.index(month)
				day = r[$2].to_i 
				year = r[$3].to_i
				calendar_date = Date.new(year, month, day)
				puts "date: " + calendar_date.to_s()
				
				message_body = message_body.split(regex_gmailreply)
				myentries = message_body[0]
			else
				calendar_date = Date.today
				myentries = message_body
			end

			puts "multipart"
		else
			myentries = message.body.decoded
			puts "not multipart"
		end
		
		#Parse the message
		regex_entries = /@([a-zA-Z0-9]+).*#(\d*\.?\d*)(.*)/
		myentries.scan(regex_entries) { |r|
			myproject = r[0]
			myhours = r[1]
			mytasks = r[2].strip
						
			#Determine if project exists - if no, create it
			proj = user.projects.find(:first, :conditions => [ "lower(name) = ?", myproject.downcase ])
			if proj.nil?
				proj = Project.create! name: myproject, user_id: user.id
			end
			
			#Create a new entry for each entry returned
			Entry.create! tasks: mytasks, project_id: proj.id , hours: myhours, user_id: user.id, cal_date: calendar_date
		
		}
		
		
	  else
	    #invalid email address - not in db
		puts "not valid user"
	  end
	end
	
		
	
end
