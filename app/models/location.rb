class Location < ApplicationRecord
  before_save :check_url_change
  belongs_to :user


  def check_url_change
    self.address = LocationsHelper.getInfo(url) if self.url_changed?
  end
end
