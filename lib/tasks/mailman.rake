#!/usr/bin/env rake

task :start_mailman_server do
  puts 'Starting Mailman Server'
  # Call the mailman server script
  system("ruby script/mailman_server")
end