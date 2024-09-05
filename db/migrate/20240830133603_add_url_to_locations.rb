class AddUrlToLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :url, :string
  end
end
