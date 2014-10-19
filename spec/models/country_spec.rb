require 'rails_helper'

RSpec.describe Country, :type => :model do
  it_behaves_like "constantizable"

  context "querying" do
    context "when queried with the country name" do
      context "Valid country" do
        context "#Country.india" do
          it "should return the India object" do
            expect(Country.india).to eq(Country.find_by_name("India"))
          end
        end

        context "#Country.pakistan" do
          it "should return the Pakistan object" do
            expect(Country.pakistan).to eq(Country.find_by_name("Pakistan"))
          end
        end

        context "#Country.united_states_of_america" do
          it "should return the United States Of America object" do
            expect(Country.united_states_of_america).to eq(Country.find_by_name("United States Of America"))
          end
        end

        context "#Country.united_kingdom" do
          it "should return the united_kingdom object" do
            expect(Country.united_kingdom).to eq(Country.find_by_name("United Kingdom"))
          end
        end
      end

      context "Invalid country" do
        context "#Country.wrong_name" do
          it "should raise an exception" do
            expect{ Country.wrong_name }.to raise_exception
          end
        end
      end
    end
  end

  context "inquiry" do
    context "when inquired with the country name" do
      context "when the name matches" do
        it "should return true" do
          expect(Country.india.india?).to eq(true)
        end
      end

      context "when the name doesn't match" do
        it "should return false" do
          expect(Country.india.united_states_of_america?).to eq(false)
        end
      end
    end
  end

end
