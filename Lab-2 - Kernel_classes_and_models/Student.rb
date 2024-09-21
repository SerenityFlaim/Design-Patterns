class Student

    attr_accessor :id
    attr_reader :phone, :name, :surname, :patronymic, :telegram, :email, :github

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
        return phone_number.nil? || phone_pattern.match?(phone_number)
    end

    #any type of name validation with regular expressions
    def self.is_name_valid?(name_string)
        name_string =~ /^[А-ЯA-Z]{1}[а-яa-z]{1,}(-[А-ЯA-Z]{1}[а-яa-z]{1,})?$/
    end

    #telegram validation with regular expressions
    def self.is_telegram_valid?(telegram_tag)
        telegram_tag.nil? || telegram_tag =~ /^@[\w]+/
    end

    #email validation with regular expressions
    def self.is_email_valid?(email_address)
        email_address.nil? || email_address =~ /^[\w+_.\-]+@[a-zA-Z.\-]+\.[a-zA-Z]{2,}$/
    end

    #github validation with regular expressions
    def self.is_github_valid?(github_url)
        github_url.nil? || github_url =~ %r{^https?://github\.com/[a-zA-Z0-9_\-]+$} #%r allows you to have '/' without escaping them
    end

    #phone setter with validation
    def phone=(phone_number)
        if (!self.class.is_phone_valid?(phone_number))
            raise "Phone number isn't stated correctly"
        end
        @phone = phone_number
    end

    #firstname setter with validation
    def name=(name)
        if (!self.class.is_name_valid?(name))
            raise "Firstname isn't stated correctly"
        end
        @name = name
    end

    #surname setter with validation
    def surname=(surname)
        if (!self.class.is_name_valid?(surname))
            raise "Surname isn't stated correctly"
        end
        @surname = surname
    end

    #patronymic setter with validation
    def patronymic=(patronymic)
        if (!self.class.is_name_valid?(patronymic))
            raise "Patronymic isn't stated correctly"
        end
        @patronymic = patronymic
    end

    #telegram setter with validation
    def telegram=(telegram)
        if (!self.class.is_telegram_valid?(telegram))
            raise "Telegram isn't stated correctly"
        end
        @telegram = telegram
    end

    #email setter with validation
    def email=(email)
        if (!self.class.is_email_valid?(email))
            raise "Email isn't stated correctly"
        end
        @email = email
    end

    #github setter with validation
    def github=(github)
        if(!self.class.is_github_valid?(github))
            raise "Github isn't stated correctly"
        end
        @github = github
    end

    def git_stated?()
        !self.github.nil?
    end

    def contacts_stated?()
        !self.phone.nil? || !self.email.nil? || !self.github.nil?
    end

    def validate?()
        self.git_stated? && self.contacts_stated?
    end


    #Show student data
    def print_info
        puts "<----------------->"
        puts "Fullname:  #{surname} #{name} #{patronymic}"
        puts "ID:        #{@id ? @id : "---"}"
        puts "Phone:     #{@phone ? @phone : "---"}"
        puts "Telegram:  #{@telegram ? @telegram : "---"}"
        puts "Email:     #{@email ? @email : "---"}"
        puts "Github:    #{@github ? @github : "---"}"
        puts "<----------------->\n\n"
    end

    private :git_stated?, :contacts_stated?
end

