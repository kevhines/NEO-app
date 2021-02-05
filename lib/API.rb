class API

    #this class will pull data from NASA
    @@api_key = "9o66xnjOVyXZJJa1cZUlGPQTsgDFB7oiA2VEIszG"
    
    def self.get_passes_for_date(date)
        url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=#{date}&end_date=#{date}&api_key=#{@@api_key}"
        response = HTTParty.get(url)
        pass_hash = {}
        asteroid_hash = {}
        response["near_earth_objects"][date].each do |pass|  
            asteroid_hash = {:id => pass["id"], :name => pass["name"], :magnitude => pass["absolute_magnitude_h"] , :diameter_min => pass["estimated_diameter"]["meters"]["estimated_diameter_min"], :diameter_max => pass["estimated_diameter"]["miles"]["estimated_diameter_max"], :hazardous => pass["is_potentially_hazardous_asteroid"], :sentry_object => pass["is_sentry_object"] }
            pass_hash = {:pass_date => date, :velocity => pass["close_approach_data"][0]["relative_velocity"]["kilometers_per_second"], :distance => pass["close_approach_data"][0]["miss_distance"]["lunar"] }
            asteroid = Asteroid.find_by_id(asteroid_hash[:id]) || Asteroid.new(asteroid_hash) 
            pass = Pass.pass_exists(date, asteroid) || Pass.new("date_search", asteroid, pass_hash) 
        end
    end

    def self.get_asteroid_visits(asteroid)
        url = "https://api.nasa.gov/neo/rest/v1/neo/#{asteroid.id}?api_key=#{@@api_key}"
        response = HTTParty.get(url)
        nextvisit =  response["close_approach_data"].select {|pass| Date.parse(pass["close_approach_date"]) > Date.today && pass["orbiting_body"] == "Earth" }.sort_by {|future_visits| Date.parse(future_visits["close_approach_date"]) }[0]
        if nextvisit
            pass_hash = {:pass_date => nextvisit["close_approach_date"], :velocity => nextvisit["relative_velocity"]["kilometers_per_second"], :distance => nextvisit["miss_distance"]["lunar"] }
            pass = Pass.new("next_visit", asteroid, pass_hash)
        else
            pass = nil
        end
        pass
    end

end