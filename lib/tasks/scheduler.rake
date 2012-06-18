#!/usr/bin/env rake

task :daily_email => :environment do
  puts "Sending daily email..."
  User.send_daily_emails
end