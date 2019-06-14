#!/usr/bin/env ruby
require_relative './lib/grailed'

case ARGV.first
when 'disallowed'
  if ARGV[1] == '--dry-run'
    puts 'users with disallowed usernames:'
    puts find_disallowed_usernames
  else
    puts 'resolving disallowed usernames...'
    change_disallowed_usernames
    puts 'done!'
  end
when 'duplicates'
  if ARGV[1] == '--dry-run'
    puts 'users with duplicate usernames:'
    puts find_duplicate_usernames
  else
    puts 'resolving duplicate usernames...'
    change_duplicate_usernames
    puts 'done!'
  end
else
  puts 'unknown command'
end
