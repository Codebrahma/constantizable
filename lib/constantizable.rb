module Constantizable 
  extend ActiveSupport::Concern

  module ClassMethods
    def method_missing(method, *args, &block)
      column_name = @constantized_column

      record = ( 
                 self.find_by("column_name = ? or column_name = ?", method.to_s, method.to_s.titleize)
               )

      if record.present?
        record
      else
        super
      end
      
    rescue Exception => e
      super
    end

    def constantize_column(column)
      @constantized_column = column
    end
  end


  def method_missing(method, *args, &block)
    if method[-1] == '?'
      column_name = self.class.instance_variable_get(:@constantized_column)
      data = self.send(column_name)
      method[0..-2] == data.titleize.tr(' ','').underscore
    else
      super
    end
  end
end
