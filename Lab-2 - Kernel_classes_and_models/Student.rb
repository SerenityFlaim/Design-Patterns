class Student

    attr_accessor :id, :name, :surname, :patronymic, :phone, :telegram, :email, :github

    #Student constructor
    def initialize(params)

        if (!params[:name]) then
            raise "Name not stated"
        end
        self.name = params[:name]

        if (!params[:surname]) then
            raise "Surname not stated"
        end
        self.surname = params[:surname]

        if (!params[:patronymic]) then
            raise "Patronymic not stated"
        end
        self.patronymic = params[:patronymic]

        self.id = params[:id]
        self.phone = params[:phone]
        self.telegram = params[:telegram]
        self.email = params[:email]
        self.github = params[:github]

    end

    #Show student data
    def print_info
        puts "<----------------->"
        puts "Fullname: #{surname} #{name} #{patronymic}"
        puts "ID: #{@id ? @id : "---"}"
        puts "Phone: #{@phone ? @phone : "---"}"
        puts "Telegram: #{@telegram ? @telegram : "---"}"
        puts "Email: #{@email ? @email : "---"}"
        puts "Github: #{@github ? @github : "---"}"
        puts "<----------------->\n\n"
    end

end

