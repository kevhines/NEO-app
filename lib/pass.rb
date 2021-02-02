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

    def self.by_date(date, sort = "all")
        date = "2015-09-07" # for now
        passes = self.all.select do |pass|
            pass.date == date
        end
        if sort != "all"
            sorted = passes.sort_by do |pass|
                -pass.distance.to_f
            end
            sorted = sorted[0...4]
        else
            sorted = passes
        end
        binding.pry
        sorted
    end

    def self.sorted_by_date(date,sort = "all")
    end


end