class Student

    attr_accessor :id, :name, :surname, :patronymic, :phone, :telegram, :email, :github

    #Student constructor
    def initialize(name, surname, patronymic, id = nil, phone = nil, telegram = nil, email = nil, github = nil)
        @id = id
        @name = name
        @surname = surname
        @patronymic = patronymic
        @phone = phone
        @telegram = telegram
        @email = email
        @github = github
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

