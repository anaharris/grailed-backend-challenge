require "rspec"
require "fileutils"
require "grailed"

def restore_db
  FileUtils.cp('grailed-exercise-backup.sqlite3', 'grailed-exercise.sqlite3')
end

context "Grailed backend code challenge" do

  describe "#find_disallowed_usernames" do
    it "returns array" do
      expect(find_disallowed_usernames.class).to eq(Array)
    end

    it "array should contain database table rows" do
      expect(find_disallowed_usernames.first.class).to eq(SQLite3::ResultSet::HashWithTypesAndFields)
    end
  end

  describe "#change_disallowed_usernames" do
    it "updates the 25 affected rows correctly" do
      expect(find_disallowed_usernames.length).to eq(25)
      change_disallowed_usernames # changes the records
      expect(find_disallowed_usernames.length).to eq(0)
    end

    after do
      restore_db
    end
  end

  describe "#find_duplicate_usernames" do
    it "returns array" do
      expect(find_duplicate_usernames.class).to eq(Array)
    end

    it "array should contain database table rows" do
      expect(find_duplicate_usernames.first.class).to eq(SQLite3::ResultSet::HashWithTypesAndFields)
    end
  end

  describe "#change_duplicate_usernames" do
    it "updates the 681 affected rows correctly" do
      expect(find_duplicate_usernames.length).to eq(681)
      change_duplicate_usernames # changes the records
      expect(find_duplicate_usernames.length).to eq(0)
    end

    after do
      restore_db
    end
  end

  describe "#create_hashmap" do
    it "creates a good hashmap from an array of results" do
      results = [{"id" => 1, "username" => "grailed"}, {"id" => 3, "username" => "grailed"}]
      hashmap = create_hashmap(results)
      expect(hashmap).to eq({"grailed" => [1,3]})
    end
  end

end
