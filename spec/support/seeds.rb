Country.delete_all
Country.create(:name => "India", :code => "IND")
Country.create(:name => "Pakistan", :code => "PAK")
Country.create(:name => "United States Of America", :code => "USA")
Country.create(:name => "United Kingdom", :code => "UK")

Place.delete_all
Place.create(:name => "Tokyo", :code => "TKY")
Place.create(:name => "New York", :code => "NY")
Place.create(:name => "California", :code => "CAL")
