class Pass

    #each Pass connects to an Asteroid object with date, speed, and distance
    attr_accessor :asteroid, :date, :velocity, :distance
    # asteroid values: :id, :name, :magnitude, :diameter_min, :diameter_max, :hazardous, :sentry_object

    @@all = []

    def initialize (asteroid, pass_hash)
        self.asteroid = asteroid
        pass_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}=")
        end  
        @@all << self
    end

    def self.all
        @@all
    end

    def self.all_with_date(date)
        date = "2015-09-07" # for now
        self.all.select do |pass|
            pass.date == date
        end
            
    end


end