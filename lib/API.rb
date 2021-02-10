class API

    #this class will pull data from NASA
    @@api_key = "9o66xnjOVyXZJJa1cZUlGPQTsgDFB7oiA2VEIszG"
    
    def self.get_passes_for_date(date)
        url = "https://api.nasa.gov/neo/rest/v1/feed?start_date=#{date}&end_date=#{date}&api_key=#{@@api_key}"
        response = HTTParty.get(url)
    end

    def self.get_asteroid_visits(asteroid)
        url = "https://api.nasa.gov/neo/rest/v1/neo/#{asteroid.id}?api_key=#{@@api_key}"
        response = HTTParty.get(url)
        nextvisit =  response["close_approach_data"].select {|pass| Date.parse(pass["close_approach_date"]) > Date.today && pass["orbiting_body"] == "Earth" }.sort_by {|future_visits| Date.parse(future_visits["close_approach_date"]) }[0]
        if nextvisit
            pass_hash = {:pass_date => nextvisit["close_approach_date"], :velocity => nextvisit["relative_velocity"]["kilometers_per_second"], :distance => nextvisit["miss_distance"]["lunar"] }
         else
            nil
        end
    end

end