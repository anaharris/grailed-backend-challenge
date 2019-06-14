require 'sqlite3'
require 'singleton'
require 'pry'

# step 1: connect to sqlite db
class GrailedDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('grailed-exercise.sqlite3')
    # returns the same data type that was passed to the db
    self.type_translation = true
    # data returns as a hash (column => value)
    self.results_as_hash = true
  end
end

# step 2: find and print disallowed usernames
def find_disallowed_usernames
  sql = "SELECT * FROM users WHERE username IN
   (SELECT invalid_username FROM disallowed_usernames)"
  GrailedDBConnection.instance.execute(sql)
end

# step 3: find and print double usernames
def find_duplicate_usernames
  sql = "SELECT * FROM users
  WHERE username IN
    (SELECT username FROM users GROUP BY username HAVING COUNT(*) > 1)  AND username NOT IN
    (SELECT invalid_username FROM disallowed_usernames)"
  GrailedDBConnection.instance.execute(sql)
end

# step 4: make a hashmap of users with disallowed usernames
def disallowed_usernames_hashmap
  users = find_disallowed_usernames()
  hashmap = {}
  users.each do |user|
    hashmap[user["username"]] ? hashmap[user["username"]] << user["id"] : hashmap[user["username"]] = [user["id"]]
  end
  hashmap
end

# step 5: make a hashmap of users with duplicate usernames
def duplicate_usernames_hashmap
  users = find_duplicate_usernames()
  hashmap = {}
  users.each do |user|
    hashmap[user["username"]] ? hashmap[user["username"]] << user["id"] : hashmap[user["username"]] = [user["id"]]
  end
  hashmap
end

# step 6: change disallowed usernames
def change_disallowed_usernames
  usernames_hash = disallowed_usernames_hashmap()
  sql = "BEGIN TRANSACTION;"
  usernames_hash.each do |username, ids|
    ids.each_with_index do |id, index|
      new_username = "#{username}#{index+1}"
      sql << "UPDATE users SET username = '#{new_username}' WHERE id = #{id};"
    end
  end
  sql << "END;"
  GrailedDBConnection.instance.execute(sql)
end


# step 7: change duplicate usernames
def change_duplicate_usernames
  usernames_hash = duplicate_usernames_hashmap()
  sql = "BEGIN TRANSACTION;"
  usernames_hash.each do |username, ids|
    ids.each_with_index do |id, index|
      if index > 0
        new_username = "#{username}#{index}"
        sql << "UPDATE users SET username = '#{new_username}' WHERE id = #{id};"
      end
    end
  end
  sql << "END;"
  puts sql
  # GrailedDBConnection.instance.execute(sql)
end