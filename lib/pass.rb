class Pass

    #each Pass connects to an Asteroid object with date, speed, and distance
    attr_accessor :asteroid, :date, :velocity, :distance

    def initialize (asteroid, pass_hash)
        self.asteroid = asteroid
        pass_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}=")
        end  
    end

end