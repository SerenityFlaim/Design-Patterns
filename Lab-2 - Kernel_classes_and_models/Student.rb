class Student

    attr_accessor :id
    attr_reader :phone, :name, :surname, :patronymic, :telegram, :email, :github

    #Student constructor
    def initialize(params)
        
        if (!params[:name]) then
            raise ArgumentError "Name not stated"
        end
        self.name = params[:name]

        if (!params[:surname]) then
            raise ArgumentError "Surname not stated"
        end
        self.surname = params[:surname]

        if (!params[:patronymic]) then
            raise ArgumentError "Patronymic not stated"
        end
        self.patronymic = params[:patronymic]

        self.id = params[:id]
        self.github = params[:github]
        self.set_contacts(params)

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
    private def phone=(phone_number)
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
    private def telegram=(telegram)
        if (!self.class.is_telegram_valid?(telegram))
            raise "Telegram isn't stated correctly"
        end
        @telegram = telegram
    end

    #email setter with validation
    private def email=(email)
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

    #checks whether github is stated
    def git_stated?()
        !self.github.nil?
    end

    #checks whether contacts are stated
    def contacts_stated?()
        !self.phone.nil? || !self.email.nil? || !self.telegram.nil?
    end

    #checks whether git or contacts stated in an instance
    def validate?()
        self.git_stated? && self.contacts_stated?
    end

    #to_s method override
    def to_s()
        "Fullname:  #{surname} #{name} #{patronymic}\n" +
        "ID:        #{@id ? @id : "---"}\n" +
        "Phone:     #{@phone ? @phone : "---"}\n" + 
        "Telegram:  #{@telegram ? @telegram : "---"}\n" +
        "Email:     #{@email ? @email : "---"}\n" +
        "Github:    #{@github ? @github : "---"}\n"
    end

    #show info about student
    def print_info()
        puts "<----------------->"
        puts (self)
        puts "<----------------->\n\n"
    end

    def set_contacts(contacts)
        self.phone = contacts[:phone]
        self.telegram = contacts[:telegram]
        self.email = contacts[:email]
    end

    private :git_stated?, :contacts_stated?
end

