require "./person.rb"
require "date"
class Student < Person
    include Comparable

    attr_reader :phone, :name, :surname, :patronymic, :telegram, :email, :birthdate

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
        self.birthdate = params[:birthdate]
    end

    #any type of name validation with regular expressions
    def self.is_name_valid?(name_string)
        name_string =~ /^[А-ЯA-Z]{1}[а-яa-z]{1,}(-[А-ЯA-Z]{1}[а-яa-z]{1,})?$/
    end

    #firstname setter with validation
    def name=(name)
        if (!self.class.is_name_valid?(name))
            raise ArgumentError "Firstname isn't stated correctly"
        end
        @name = name
    end
    
    #surname setter with validation
    def surname=(surname)
        if (!self.class.is_name_valid?(surname))
            raise ArgumentError "Surname isn't stated correctly"
        end
        @surname = surname
    end
    
    #patronymic setter with validation
    def patronymic=(patronymic)
        if (!self.class.is_name_valid?(patronymic))
            raise ArgumentError "Patronymic isn't stated correctly"
        end
        @patronymic = patronymic
    end

    #phone setter with validation
    private def phone=(phone_number)
        if (!self.class.is_phone_valid?(phone_number))
            raise ArgumentError "Phone number isn't stated correctly"
        end
        @phone = phone_number
    end

    #telegram setter with validation
    private def telegram=(telegram)
        if (!self.class.is_telegram_valid?(telegram))
            raise ArgumentError "Telegram isn't stated correctly"
        end
        @telegram = telegram
    end

    #email setter with validation
    private def email=(email)
        if (!self.class.is_email_valid?(email))
            raise ArgumentError "Email isn't stated correctly"
        end
        @email = email
    end

    #birthdate setter
    private def birthdate=(birthdate)
        begin
            @birthdate = Date.strptime(birthdate, '%d-%m-%Y')
        rescue Exception
            raise ArgumentError "Date in wrong format"
        end
    end

    #telegram validation with regular expressions
    def self.is_telegram_valid?(telegram_tag)
        telegram_tag.nil? || telegram_tag =~ /^@[\w]+/
    end

    #email validation with regular expressions
    def self.is_email_valid?(email_address)
        email_address.nil? || email_address =~ /^[\w+_.\-]+@[a-zA-Z.\-]+\.[a-zA-Z]{2,}$/
    end

    #phone validation with regular expressions
    def self.is_phone_valid?(phone_number)
        phone_pattern = Regexp.compile(/^(?:\+7|8)[\s-]?(?:\(?\d{3}\)?[\s-]?)\d{3}[\s-]?\d{2}[\s-]?\d{2}$/)
        return phone_number.nil? || phone_pattern.match?(phone_number)
    end

    #to_s method override
    def to_s()
        "<----------------->\n" +
        "Fullname:  #{surname} #{name} #{patronymic}\n" +
        "ID:        #{@id ? @id : "---"}\n" +
        "Phone:     #{@phone ? @phone : "---"}\n" + 
        "Telegram:  #{@telegram ? @telegram : "---"}\n" +
        "Email:     #{@email ? @email : "---"}\n" +
        "Github:    #{@github ? @github : "---"}\n" +
        "Birthdate: #{@birthdate ? birthdate.strftime("%d-%m-%Y") : "---"}\n" + #"#{birthdate.day}-#{birthdate.month}-#{birthdate.year}"
        "<----------------->\n\n"
    end

    #sets contacts through hash
    def set_contacts(contacts)
        self.phone = contacts[:phone]
        self.telegram = contacts[:telegram]
        self.email = contacts[:email]
    end

    #gets fullname in a short format
    def get_initials()
        "#{self.surname} #{self.name[0]}.#{self.patronymic[0]}."
    end

    #gets github url if provided
    def get_git()
        if(git_stated?) then
            self.github
        else
            "github not provided."
        end
    end

    #gets contact if provided in listed order
    def get_contact()
        if (self.contacts_stated?)
            if (telegram) then
                "telegram: #{self.telegram}"
            elsif (email) then
                "email: #{self.email}"
            elsif (phone) then
                "phone: #{self.phone}"
            end
        else
            "no contacts provided."
        end
    end

    #info about a student in a single line
    def get_info()
        "#{get_initials} #{get_git} #{get_contact}"
    end

    #spaceship compares by birthdate
    def <=>(other)
        return self.birthdate <=> other.birthdate
    end

    private :git_stated?, :contacts_stated?
end