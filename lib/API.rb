class API

    #this class will pull data from NASA
    @@api_key = "9o66xnjOVyXZJJa1cZUlGPQTsgDFB7oiA2VEIszG"
    
    def self.get_passes_for_date(date)
        url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-07&api_key=#{@@api_key}"
        response = HTTParty.get(url)
        puts "got here"

        # if response["message"]
        #     return false
        #   end
        # weather_hash = {zip_code: zip, name: response["name"], wind_speed: response["wind"]["speed"], temp: response["main"]["temp"], feels_like: response["main"]["feels_like"], cloud_cover: response["weather"][0]["description"]}
        #Location.new(weather_hash)
        
        #loop through data and create all the passes
        pass_hash = {}
        asteroid_hash = {}
        response["near_earth_objects"]["2015-09-07"].each do |pass|  #["2015-09-07"]
            pass_hash = {:date => date, :velocity => pass["close_approach_data"][0]["relative_velocity"]["miles_per_hour"], :distance => pass["close_approach_data"][0]["miss_distance"]["miles"] }
            asteroid_hash = {:id => pass["id"], :name => pass["name"], :magnitude => pass["absolute_magnitude_h"] , :diameter_min => pass["estimated_diameter"]["miles"]["estimated_diameter_min"], :diameter_max => pass["estimated_diameter"]["miles"]["estimated_diameter_max"], :hazardous => pass["is_potentially_hazardous_asteroid"], :sentry_object => pass["is_sentry_object"] }
            #Pass.create_pass()
            binding.pry
        end
        puts "got data"
    end

end