require 'sqlite3'
require 'singleton'

# connects to sqlite db
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

# finds disallowed usernames
def find_disallowed_usernames
  sql = "SELECT * FROM users WHERE username IN
          (SELECT invalid_username FROM disallowed_usernames)"
  GrailedDBConnection.instance.execute(sql)
end

# finds duplicate usernames
def find_duplicate_usernames
  sql = "SELECT * FROM users
          WHERE username IN
            (SELECT username FROM users GROUP BY username HAVING COUNT(*) > 1)
          AND username NOT IN
            (SELECT invalid_username FROM disallowed_usernames)"
  GrailedDBConnection.instance.execute(sql)
end

# makes a hashmap of usernames to their ids
def create_hashmap(users)
  hashmap = {}
  users.each do |user|
    hashmap[user["username"]] ? hashmap[user["username"]] << user["id"] : hashmap[user["username"]] = [user["id"]]
  end
  hashmap
end

# creates sql update statement
def sql_update_statement(username, id)
  "UPDATE users SET username = '#{username}' WHERE id = #{id};"
end

# changes disallowed usernames
def change_disallowed_usernames
  users = find_disallowed_usernames
  usernames_hash = create_hashmap(users)
  usernames_hash.each do |username, ids|
    ids.each_with_index do |id, index|
      new_username = "#{username}#{index+1}"
      sql = sql_update_statement(new_username, id)
      GrailedDBConnection.instance.execute(sql)
    end
  end
end

# changes duplicate usernames
def change_duplicate_usernames
  users = find_duplicate_usernames
  usernames_hash = create_hashmap(users)
  usernames_hash.each do |username, ids|
    ids.each_with_index do |id, index|
      if index > 0
        new_username = "#{username}#{index}"
        sql = sql_update_statement(new_username, id)
        GrailedDBConnection.instance.execute(sql)
      end
    end
  end
end
