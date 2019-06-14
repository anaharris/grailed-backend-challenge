require "rspec"
require "grailed"


describe "#find_disallowed_usernames" do
  it "returns array" do
    expect(find_disallowed_usernames.class).to eq(Array)
  end

  it "array shouldn't be empty" do
    expect(find_disallowed_usernames.empty?).to eq(false)
  end

  it "array should contain database table rows" do
    expect(find_disallowed_usernames.first.class).to eq(SQLite3::ResultSet::HashWithTypesAndFields)
  end
end

describe "#find_double_usernames" do
  it "returns array" do
    expect(find_duplicate_usernames.class).to eq(Array)
  end

  it "array shouldn't be empty" do
    expect(find_duplicate_usernames.empty?).to eq(false)
  end

  it "array should contain database table rows" do
    expect(find_duplicate_usernames.first.class).to eq(SQLite3::ResultSet::HashWithTypesAndFields)
  end
end

describe "#disallowed_usernames_hashmap" do
  it "returns a hash" do
    expect(disallowed_usernames_hashmap.class).to eq(Hash)
  end
end

describe "#duplicate_usernames_hashmap" do
  it "returns a hash" do
    expect(duplicate_usernames_hashmap.class).to eq(Hash)
  end
end
