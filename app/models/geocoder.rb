class Geocoder

  attr_reader :options

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

end
