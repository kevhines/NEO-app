class Asteroid

    attr_accessor :id, :name, :magnitude, :diameter_min, :diameter_max, :hazardous, :sentry_object

    @@all = []

    def initialize(asteroid_hash)
        asteroid_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}=")
        end
        @@all << self
    end

    def self.find_by_id(asteroid_id)
        self.all.find { |asteroid| asteroid.id == asteroid_id }
    end

    def self.all
        @@all
    end


end