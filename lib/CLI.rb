class CLI
    #this class will interface wih the user

    @date = Date.today.strftime('%Y-%m-%d')
    @sort = "all"

    attr_reader :date 
    attr_accessor :sort

    def run_app
        puts "Welcome to the NEO app"
        puts "NEO stands for Near Earth Objects. In this case we are talking about Asteroids."
        puts "Enter a date to see what Asteroids are flying by Earth on that day (mm-dd-yyyy):"
        self.get_date
    end

    def get_date        
        input = gets.chomp
        @date = checks_date(input)
        puts "date entered, and ignored for now: " + self.date
        API.get_passes_for_date(self.date)
        self.option_menu(true)
    end

    def checks_date(input)
        new_date = nil
        if input.split(/\/|-/).size == 3 
            begin
                new_date = Date.parse(input.split(/\/|-/)[2] + "-" + input.split(/\/|-/)[0] + "-" + input.split(/\/|-/)[1])
                rescue ArgumentError
                    new_date = nil
                end
            end
        if !new_date
            puts "Invalid Date Format. Try Again (mm-dd-yyyy):"
            self.get_date
        end
        #binding.pry
        new_date.strftime('%Y-%m-%d')
    end


    def option_menu(first = false)
        puts "You are viewing Near Earth Asteroids from #{self.date}"
       # binding.pry
        puts "there are #{Pass.by_date(self.date).count} asteroids from that day."
        puts "Would you like to:"
        puts "1. See data for the 5 biggest asteroids?"
        puts "2. See data for the 5 closest asteroids?"
        puts "3. See data for all of the asteroids?"
        puts "4. Enter a new date?"
        puts "5. Would you like to see when one of the Asteroids listed above will fly by Earth next?" unless first
        puts "Please choose one of the numbers above:"
        input = gets.chomp
        case input
        when "1"
            self.sort = "biggest"
        when "2"
            self.sort = "closest"
        when "3"
            self.sort = "all"
        when "4"
            puts "Enter a new date (mm-dd-yyyy):"
            self.get_date
        when "5"
            #this functionality is not built yet
            puts "Please Enter the number of the asteroid you'd like to check:" # unless first
            self.choose_asteroid
        else
            puts "Please enter one of the options listed above:"
            self.option_menu(first)
        end
            self.print_passes
    end


    def print_passes
        puts "name - average diameter - distance from Earth"
        passes = []
        if self.sort == "biggest" || self.sort == "closest"
            passes = Pass.sorted_list(self.date, self.sort)
         #   binding.pry
        else
            passes = Pass.by_date(self.date)
        end
        passes.each_with_index do |pass,i|
             #binding.pry
             avg_diamater = (pass.asteroid.diameter_min + pass.asteroid.diameter_max) / 2 
             puts "#{i+1}. #{pass.asteroid.name} - #{avg_diamater.round(3)} miles - #{pass.distance.to_f.round()} miles "   
         end
         puts "Press Any key for Options"
         STDIN.getch
         self.option_menu
    end

    def choose_asteroid
        input = gets.chomp  
        if self.sort == "all"
            asteroid = Pass.by_date(self.date)[input.to_i - 1].asteroid
        else
            asteroid = Pass.sorted_list(self.date, self.sort)[input.to_i - 1].asteroid
        end
      #  binding.pry
        self.print_asteroid(asteroid)
    end

    def print_asteroid(asteroid)
        #asteroid.get_next_visit
        API.get_asteroid_visits(asteroid.id)
        puts "nice work"
        self.option_menu
    end

end