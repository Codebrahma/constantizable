require 'rails_helper'

RSpec.describe Place, :type => :model do
  context "querying" do
    it "should fallback to the default method_missing impl" do
      expect{ Place.test_place }.to raise_exception
    end
  end

  context "inquiry" do
    it "should fallback to the default method_missing impl" do
      expect{ Place.first.test_place? }.to raise_exception
    end
  end
end
