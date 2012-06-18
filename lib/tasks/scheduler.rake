#!/usr/bin/env rake

task :daily_email do
  puts 'Sending daily email...'
  User.daily_email
end