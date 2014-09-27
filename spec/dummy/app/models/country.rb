class Country < ActiveRecord::Base
  include Constantizable
  
  constantize_column :name
end
