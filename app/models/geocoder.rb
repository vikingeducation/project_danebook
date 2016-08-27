class Geocoder

  attr_reader :options, :results

  include HTTParty
  base_uri "https://maps.googleapis.com/"
  GOOGLE_MAPS_API_KEY = Rails.application.secrets.google_maps_api_key

  def initialize(address={})
    @options = { query: { 'key' => GOOGLE_MAPS_API_KEY } }
    set_ivars(address)
    prep_query
    self
  end

  def search
    @results = self.class.get("/maps/api/geocode/json", @options)
    !(@results['status'] == 'ZERO_RESULTS')
  end

  def parsed_results
    # @parsed_results ||= @results.parsed_response['regionchildren']['response']['list']['region']
  end

  private

    # Setters.
    def street_address=(street)
      @street = street
    end

    def city=(city)
      @city = city
    end

    def state=(state)
      @state = state
    end

    def zip_code=(zip)
      @zip = zip
    end

    def country=(country)
      @country = country
    end

    def set_ivars(address)
      address.each do |k,v|
        send("#{k}=".to_sym,v)
      end
    end

    # Preparing the options hash.
    def prep_query
      address = "#{@street}, #{@city}, #{@state} #{@zip}"
      @options[:query]['address'] = address
    end

  # # Creates a hash of the name and zestimate
  # def zestimates
  #   parsed_results
  #   @parsed_results.map do |result|
  #     zestimate = result['zindex']['__content__'].to_i unless result['zindex'].nil?
  #     {name: result['name'],zestimate: zestimate}
  #   end
  # end
  #
  # def coordinates
  #   parsed_results
  #   @parsed_results.map do |result|
  #     coords = { lat: result['latitude'], lon: result['longitude'] }
  #     {name: result['name'],coords: coords}
  #   end
  # end

end
