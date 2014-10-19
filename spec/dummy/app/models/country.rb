class Country < ActiveRecord::Base
  constantize_column :name, :code, :id
end
