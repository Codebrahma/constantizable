module Constantizable
  extend ActiveSupport::Concern
  # Constantizable extends `ActiveSupport::Concern` for some of the rails niceties
  # like, `ClassMethods` and to include it into `ActiveRecord::Base`.

  module ClassMethods
    def constantize_column(*columns)
      # This method is set as a class method as it can directly be invoked from model definitions
      # as follows.

      # Class Country < ActiveRecord::Base
      #   constantize_columns :name, :code
      # end

      @constantized_columns = columns
    end

    private

    def method_missing(method, *args, &block)
      # In the case that an object's constantized column value corresponds to the method name,
      # the object is returned, else execution is delegated to the default `method_missing`
      # implementation.

      # If Column name isn't present it should fallback to the default `method_missing`
      # implementation.

      column_names = @constantized_columns
      super if column_names.blank?

      # The value of the constantized column needs to be titleized or underscored,
      # for the implementation to work.
      # (eg)
      # Country with name "United States Of America", will correspond to the query,
      # Country.united_states_of_america.
      # Country with name "India", will correspond to the query,
      # Country.india.
      # Country with name "united_kingdom", will correspond to the query,
      # Country.united_kingdom.
      record = nil
      column_names.each do |column_name|
        break if record.present?
        record = find_by("lower(#{column_name}) = ? or lower(#{column_name}) = ?", method.to_s.downcase, method.to_s.titleize.downcase)
      end

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
      m = method.to_s.delete('?')
      column_names = self.class.instance_variable_get(:@constantized_columns)
      super if column_names.blank?

      # The value of the constantized column needs to be titleized or underscored.
      record = nil
      column_names.each do |column_name|
        break if record.present?
        record = self.class.find_by("lower(#{column_name}) = ? or lower(#{column_name}) = ?", m.to_s.downcase, m.to_s.titleize.downcase)
      end

      if record.present?
        id == record.id
      else
        super
      end
    else
      super
    end
  end
end

ActiveRecord::Base.send(:include, Constantizable)
