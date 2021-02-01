class CLI
    #this class will interface wih the user

    def run_app
        puts "Welcome to the NEO app"
        puts "NEO stands for Near Earth Objects. In this case we are talking about Asteroids."
        self.get_date
    end

    def get_date
        puts "Enter a date to see what Asteroids are flying by Earth on that day (mm-dd-yyyy):"
        input = gets.chomp
        puts input
    end

end