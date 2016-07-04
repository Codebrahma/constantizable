class Country < ActiveRecord::Base
  constantize_column :name, :code, :id
end
class Place < ActiveRecord::Base
  # THIS MODEL ISN'T CONSTANTIZED
  # constantize_column :name
end
