module Constantizable
  extend ActiveSupport::Concern
  # Constantizable extends `ActiveSupport::Concern` for some of the rails niceties
  # like, `ClassMethods` and to include it into `ActiveRecord::Base`.

  module ClassMethods
    def constantize_column(column)
      # This method is set as a class method as it can directly be invoked from model definitions
      # as follows.

      # Class Country < ActiveRecord::Base
      #   constantize_column :name
      # end

      @constantized_column = column
    end

  private
    def method_missing(method, *args, &block)
      # In the case that an object's constantized column value corresponds to the method name,
      # the object is returned, else execution is delegated to the default `method_missing` 
      # implementation.

      # If Column name isn't present it should fallback to the default `method_missing` 
      # implementation.

      column_name = @constantized_column
      super if column_name.nil?

      # The value of the constantized column needs to be titleized or underscored, 
      # for the implementation to work.
      # (eg)
      # Country with name "United States Of America", will correspond to the query,
      # Country.united_states_of_america.
      # Country with name "India", will correspond to the query,
      # Country.india.
      # Country with name "united_kingdom", will correspond to the query,
      # Country.united_kingdom.

      record = ( 
                 self.find_by("#{column_name} = ? or #{column_name} = ?", method.to_s, method.to_s.titleize)
               )

      if record.present?
        record
      else
        super
      end
      
    rescue
      super
    end
  end


  def method_missing(method, *args, &block)
    # Refer https://github.com/rails/rails/blob/master/activesupport/lib/active_support/string_inquirer.rb
    # Inquiry happens only if method is an inquiry method (i.e) method name ends with a '?'

    if method[-1] == '?'
      # If Column name isn't present it should fallback to the default `method_missing` 
      # implementation.

      column_name = self.class.instance_variable_get(:@constantized_column)
      super if column_name.nil?

      # The value of the constantized column needs to be titleized or underscored.
      # The value of the constantized column is compared with the titelized version
      # of the method name after stripping the '?' at the end.

      data = self.send(column_name)
      method[0..-2] == data.titleize.tr(' ','').underscore
    else
      super
    end
  end
end

ActiveRecord::Base.send(:include, Constantizable)