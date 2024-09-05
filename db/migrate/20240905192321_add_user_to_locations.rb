class AddUserToLocations < ActiveRecord::Migration[7.1]
  def change
    add_reference :locations, :user, index: true
  end
end
