module LocationsHelper
  require 'httparty'
  require 'json'

  def self.getLatLong(url)
    response = HTTParty.get(url, follow_redirects: false)
    location = response.headers['location']
    split_location = location.split('/')
    coords_index = split_location[4] == 'place' ? 6 : 5

    return location.split('/')[coords_index].gsub(/[^0-9,\.]/, '').split(',')[0..1].join(',')
  end

  def self.getInfo(url)
    lat = getLatLong(url)
    api_key = ENV['GOOGLE_MAPS_API_KEY']
    url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat}&key=#{api_key}"
    response = HTTParty.get(url)
    info = JSON.parse(response.body)

    longName = info['results'][0]["address_components"]
    arr = longName.reverse.map do |info|
      info["long_name"]
    end
    return arr.join(', ') 
  end
end
