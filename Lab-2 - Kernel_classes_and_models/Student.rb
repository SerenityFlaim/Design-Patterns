class Student

    attr_accessor :id, :name, :surname, :patronymic, :telegram, :email, :github
    attr_reader :phone

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

    #phone validation with regular expressions
    def self.is_phone_valid?(phone_number)
        phone_pattern = Regexp.compile(/^(?:\+7|8)[\s-]?(?:\(?\d{3}\)?[\s-]?)\d{3}[\s-]?\d{2}[\s-]?\d{2}$/)
        return phone_pattern.match?(phone_number)
    end

    #phone setter with validation
    def phone=(phone_number)
        if (!self.class.is_phone_valid?(phone_number))
            raise "Phone number isn't stated correctly"
        end
        @phone = phone_number
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

