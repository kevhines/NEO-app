class Asteroid

    #object for asteroids, name, next fly by day (optional), ID

    attr_accessor :id, :name, :magnitude, :diameter_min, :diameter_max, :hazardous, :sentry_object

    def initialize(asteroid_hash)
        asteroid_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}=")
        end
    end

end