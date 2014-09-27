Country.delete_all
Country.create(:name => "India")
Country.create(:name => "Pakistan")
Country.create(:name => "United States Of America")
Country.create(:name => "united_kingdom")

Place.delete_all
Place.create(:name => "Test place")