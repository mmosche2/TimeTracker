#!/usr/bin/env rake

task :start_mailman_server do
  puts 'Starting Mailman Server'
  # Call the mailman server script
  `script/mailman_server`
end