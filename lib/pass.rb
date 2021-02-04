class Pass

    attr_accessor :asteroid, :pass_date, :velocity, :distance

    @@all = []
    @@all_searches = []
    @@next_visitation = []

    def initialize (full_date_search, asteroid, pass_hash)
        self.asteroid = asteroid
        pass_hash.each do |key, value|
            self.send("#{key}=", value) if self.respond_to?("#{key}=")
        end  
        @@all << self
        @@all_searches << self.pass_date if full_date_search == "date_search" && !self.class.exist_by_date(self.pass_date)
        @@next_visitation << self.asteroid if full_date_search == "next_visit"
    end

    def self.all
        @@all
    end

    def self.all_searches
        @@all_searches
    end

    def self.next_visitation
        @@next_visitation
    end

    def self.exist_by_date(date)
        self.all_searches.include?(date)
    end

    def self.next_visit_exists?(asteroid)
        next_visit = nil
        if self.next_visitation.include?(asteroid)
            next_visit = self.all.sort_by { |pass| Date.parse(pass.pass_date) }.find do |sorted_pass|
                sorted_pass.asteroid == asteroid
                Date.parse(sorted_pass.pass_date) > Date.today   
            end
        end
        next_visit
    end

    def self.by_date(date)
        self.all.select do |pass|
            pass.pass_date == date
        end
       
    end

    def self.sorted_list(date,sort = "all")
        passes = self.by_date(date)
        if sort == "closest"
            sorted = passes.sort_by do |pass|
                pass.distance.to_f
            end
        elsif sort == "biggest"
            sorted = passes.sort_by do |pass|
                -avg_diamater = (pass.asteroid.diameter_min + pass.asteroid.diameter_max) / 2 
            end           
        else
            sorted = passes
        end
        sorted[0...5]
    end


end