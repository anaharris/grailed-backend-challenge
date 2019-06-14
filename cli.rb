require_relative './lib/grailed'

# runs all other functions
def main
  puts 'disallowed usernames:'
  puts find_disallowed_usernames()
  puts '**********************************'
  puts 'duplicate usernames:'
  puts find_duplicate_usernames()
end

main()
# puts disallowed_usernames_hashmap()
# puts duplicate_usernames_hashmap()
# change_disallowed_usernames()
# change_duplicate_usernames()
