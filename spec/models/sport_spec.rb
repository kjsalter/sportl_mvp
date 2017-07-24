require "rails_helper"

RSpec.describe Sport, :type => :model do

  it "is invalid when name is not present" do
    invalid_sport = Sport.new
    expect(invalid_sport).not_to be_valid
  end

  it "is valid when name is present" do
    valid_sport = Sport.new(name: "Football")
    expect(valid_sport).to be_valid
  end
end
