class CLI
    #this class will interface wih the user

    def run_app
        puts "Welcome to the NEO app"
        puts "NEO stands for Near Earth Objects. In this case we are talking about Asteroids."
        puts "Enter a date to see what Asteroids are flying by Earth on that day (mm-dd-yyyy):"
        self.get_date
    end

    def get_date        
        input = gets.chomp
        date = checks_date(input)
        puts "date entered, and ignored for now: " + date
        API.get_passes_for_date(date)
        self.option_menu(date,true)
    end

    def checks_date(date)
        new_date = nil
        if date.split(/\/|-/).size == 3 # && date.tr("/-","").scan(/\D/).empty?
            begin
                new_date = Date.parse(date.split(/\/|-/)[2] + "-" + date.split(/\/|-/)[0] + "-" + date.split(/\/|-/)[1])
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


    def option_menu(date,first = false)
        puts "You are viewing Near Earth Asteroids from #{date}"
        #binding.pry
        puts "there are #{Pass.by_date(date).count} asteroids from that day."
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
            self.print_passes(date, "biggest")
        when "2"
            self.print_passes(date, "closest")
        when "3"
            self.print_passes(date, "all")
        when "4"
            puts "Enter a new date (mm-dd-yyyy):"
            self.get_date
        when "5"
            #this functionality is not built yet
            puts "Please Enter the number of the asteroid you'd like to check:" unless first
            self.get_date #for now eventually choose_asteroid
        else
            puts "Please enter one of the options listed above:"
            self.option_menu(date)
        end
    end


    def print_passes(date, sort = "all")
        puts "name - average diameter - distance from Earth"
        passes = []
        if sort == "biggest" || sort == "closest"
            passes = Pass.sorted_list(date, sort)
        else
            passes = Pass.by_date(date)
        end

        passes.each_with_index do |pass,i|
             #need to limit by date
             #binding.pry
             avg_diamater = (pass.asteroid.diameter_min + pass.asteroid.diameter_max) / 2 
             puts "#{i+1}. #{pass.asteroid.name} - #{avg_diamater.round(3)} miles - #{pass.distance.to_f.round()} miles "   
         end
         puts "Press Any key for Options"
         STDIN.getch
         self.option_menu(date)


    end
end