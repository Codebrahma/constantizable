class AddCodeToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :code, :string
  end

  def self.down
    remove_column :places, :code
  end
end
