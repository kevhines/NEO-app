class API

    #this class will pull data from NASA
    @@api_key = "9o66xnjOVyXZJJa1cZUlGPQTsgDFB7oiA2VEIszG"
    
    def self.get_passes_for_date(date)
        date = "2015-09-07" # for now
        url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=#{date}&end_date=#{date}&api_key=#{@@api_key}"
        response = HTTParty.get(url)
        #loop through data and create all the passes
        pass_hash = {}
        asteroid_hash = {}
        response["near_earth_objects"][date].each do |pass|  
            asteroid_hash = {:id => pass["id"], :name => pass["name"], :magnitude => pass["absolute_magnitude_h"] , :diameter_min => pass["estimated_diameter"]["miles"]["estimated_diameter_min"], :diameter_max => pass["estimated_diameter"]["miles"]["estimated_diameter_max"], :hazardous => pass["is_potentially_hazardous_asteroid"], :sentry_object => pass["is_sentry_object"] }
            pass_hash = {:date => date, :velocity => pass["close_approach_data"][0]["relative_velocity"]["miles_per_hour"], :distance => pass["close_approach_data"][0]["miss_distance"]["miles"] }
            asteroid = Asteroid.new(asteroid_hash)
            pass = Pass.new(asteroid, pass_hash)
           # binding.pry
        end
    end

end