class CLI
    #this class will interface wih the user

    def run_app
        puts "Welcome to the NEO app"
        puts "NEO stands for Near Earth Objects. In this case we are talking about Asteroids."
        puts "Enter a date to see what Asteroids are flying by Earth on that day (mm-dd-yyyy):"
        self.get_date
    end

    def get_date        
        date = gets.chomp
        checks_date(date)
        puts date
        API.get_passes_for_date(date)
    end

    def checks_date(date)
        new_date = nil
        if date.split(/\/|-/).size == 3
            new_date = Date.parse(date.split(/\/|-/)[2] + "-" + date.split(/\/|-/)[0] + "-" + date.split(/\/|-/)[1])
        end
        if date.split(/\/|-/).size != 3 || !new_date
            puts "Invalid Date Format. Try Again (mm-dd-yyyy):"
            self.get_date
        end
        #binding.pry
        new_date
    end

end