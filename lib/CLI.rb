class CLI
    #this class will interface wih the user

    @date = Date.today.strftime('%Y-%m-%d')
    @sort = "all"

    attr_reader :date 
    attr_accessor :sort

    def run_app
        system "clear"
        puts "Welcome to the NEO app"
        puts "NEO stands for Near Earth Objects. In this case we are talking about Asteroids."
        puts "Enter a date to see what Asteroids are flying by Earth on that day (mm-dd-yyyy):"
        self.get_date
    end

    def get_date        
        input = gets.chomp
        if input.upcase == "X" || input.upcase == "EXIT"
            self.exit_program
        end
        @date = checks_date(input)
        API.get_passes_for_date(self.date) unless Pass.exist_by_date(self.date)
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
        if !new_date || input.split(/\/|-/)[2].size > 4
            puts "Invalid Date Format. Try Again (mm-dd-yyyy):"
            self.get_date
        end
        new_date.strftime('%Y-%m-%d')
    end


    def option_menu(first = false)
        puts "\nYou are viewing Near Earth Asteroids from #{Date.parse(self.date).strftime('%b %d %Y').underline}"
        puts "there are " + Pass.by_date(self.date).count.to_s.underline + " asteroids".underline + " from that day."
        puts "\nWould you like to:".underline
        puts "1. See data for the 5 biggest asteroids?"
        puts "2. See data for the 5 closest asteroids?"
        puts "3. See data for all of the asteroids?"
        puts "4. Enter a new date?"
        puts "5. Would you like to see when one of the Asteroids listed above will fly by Earth next?" unless first
        puts "X. Enter X to exit this program."
        puts "\nPlease choose one of the numbers above:"
        get_user_choice(first)
    end

    def get_user_choice(first)
        input = gets.chomp
        case input.upcase
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
            if first
                puts "Invalid Choice. Please enter one of the list options listed:"
                self.option_menu(first)
            else
                puts "Please Enter the number of the asteroid you'd like to check:"
                self.choose_asteroid
            end
        when "X", "EXIT"
            self.exit_program
        else
            puts "Invalid Choice. Please enter one of the list options listed:"
            self.option_menu(first)
        end
            self.print_passes
    end


    def print_passes
        passes = []
        if self.sort == "biggest" || self.sort == "closest"
            passes = Pass.sorted_list(self.date, self.sort)
        else
            passes = Pass.by_date(self.date)
        end
        rows = []
        passes.each_with_index do |pass,i|
             avg_diamater = (pass.asteroid.diameter_min + pass.asteroid.diameter_max) / 2 
             rows << [i+1, pass.asteroid.name, avg_diamater.round(3).to_sc, pass.distance.to_f.round().to_sc]   
         end
        table = Terminal::Table.new :headings => ["","Name", "Avg Diameter\n(meters)", "Distance From Earth\n(lunars)"], :rows => rows
        puts table
        self.pause_screen
        self.option_menu
    end

    def choose_asteroid
        input = gets.chomp  
        if input.upcase == "X" || input.upcase == "EXIT"
            self.exit_program
        end
        if self.sort == "all" && input.to_i <= Pass.by_date(self.date).size && input.to_i != 0
            asteroid = Pass.by_date(self.date)[input.to_i - 1].asteroid
        elsif input.to_i <= Pass.sorted_list(self.date, self.sort).size && input.to_i != 0
            asteroid = Pass.sorted_list(self.date, self.sort)[input.to_i - 1].asteroid
        else
            puts "No Asteroid numbered #{input} in the list. Please choose another Asteroid:"
            self.choose_asteroid
        end
        self.print_asteroid(asteroid)
    end

    def print_asteroid(asteroid)
        next_visit = Pass.next_visit_exists?(asteroid) || API.get_asteroid_visits(asteroid)
        visit_info = ""
        if next_visit 
            distance_miles = next_visit.distance.to_f * 238900
            visit_info << "The asteroid designated #{next_visit.asteroid.name} will next fly by Earth on #{Date.parse(next_visit.pass_date).strftime('%b %d %Y').underline} traveling at a speed of #{next_visit.velocity.to_f.round().to_sc} kilometers per second.\nIt will miss Earth by a distance of #{next_visit.distance.to_f.round(2).to_sc} lunars."
            visit_info << "\nThat means it will be over #{distance_miles.round().to_sc} miles from Earth."
        else
            visit_info << "There is no data for future visits for the asteroid designated #{asteroid.name}."
        end
        rows = [[visit_info]]
        table = Terminal::Table.new :rows => rows
        puts table
        self.pause_screen
        self.option_menu
    end

    def pause_screen
        puts "Press Any key for Options"
        STDIN.getch
    end

    def exit_program
        abort("Thanks for using the NEO APP! We'll keep watching Earth's skies!")
      end

end