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
        puts date
        API.get_passes_for_date(date)
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
end