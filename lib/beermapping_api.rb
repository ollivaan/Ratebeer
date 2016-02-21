class BeermappingApi
  cache = ActiveSupport::Cache::MemoryStore.new(expires_in: 2.minutes)
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week) { fetch_places_in(city) }

  end

#1
  def self.place_by_id(id)
    Rails.cache.fetch("place_with_id_#{id}", expires_in: 1.week) { fetch_place_by_id(id) }
  end
#2

  private
#1
  def self.fetch_place_by_id(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"
    # http://stark-oasis-9187.herokuapp.com/api/
    # http://beermapping.com/webservice/locquery/

        response = HTTParty.get "#{url}#{ERB::Util.url_encode(id)}"
    place = response.parsed_response["bmp_locations"]["location"]

    Place.new(place)
  end
#2
  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"
    #

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.key
    "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    ENV['APIKEY']
  end
end
  # def self.key
  #   "96ce1942872335547853a0bb3b0c24db"
  # end

