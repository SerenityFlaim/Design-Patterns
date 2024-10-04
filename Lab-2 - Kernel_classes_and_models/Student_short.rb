class Student_short
    attr_reader :id, :fullname, :github, :contact
    private_class_method :new

    #default constructor
    def initialize(id, fullname, github, contact)
        self.id = id
        self.fullname = fullname
        self.github = github
        self.contact = contact
    end

    #constructor from a Student object
    def self.new_from_student(student)
        self.new(
            student.id.to_i,
            student.get_initials,
            student.github,
            student.get_contact
        )
    end

    #parse get_info string for Student_short constructor
    def self.parse_student_string(student_string)
        split = student_string.split()
        fullname, github, contact = split[0] + " " + split[1], split[2], split[3] + " " + split[4]
    end

    #constructor from an id and a string from get_info Student method
    def self.new_from_id_string(id, student_string)
        fullname, github, contact = self.parse_student_string(student_string)
        self.new(
            id,
            fullname,
            github,
            contact
        )
    end

    #id setter
    private attr_writer :id

    #fullname setter with validation
    def fullname=(fullname)
        if(!self.class.is_fullname_valid?(fullname)) then
            raise ArgumentError "Fullname isnt' stated correctly."
        end
        @fullname = fullname
    end

    #github setter with validation
    def github=(github)
        if(!self.class.is_github_valid?(github) || github.nil?) then
            raise ArgumentError "Github isn't stated correctly."
        end
        @github = github
    end

    #contact setter with validation
    def contact=(contact)
        if (contact.include? "telegram:") then
            telegram = contact.slice(9..-1).strip
            if (self.class.is_telegram_valid?(telegram)) then
                @contact = telegram
            else
                raise ArgumentError "Telegram isn't stated correctly."
            end
        elsif (contact.include? "email:")
            email = contact.slice(6..-1).strip
            if(self.class.is_email_valid?(email)) then
                @contact = email
            else
                raise ArgumentError "Email isn't stated correctly."
            end
        elsif (contact.include? "phone:")
            phone = contact.slice(6..-1).strip
            if (self.class.is_phone_valid?(phone)) then
                @contact = phone
            else
                raise ArgumentError "Phone isn't stated correctly."
            end
        else
            raise "Contact isn't stated correctly."
        end
    end

    #to_s method override
    def to_s()
        "Fullname:  #{fullname}\n" +
        "ID:        #{@id ? @id : "---"}\n" +
        "Github:    #{@github ? @github : "---"}\n" +
        "Contact:   #{@contact ? @contact : "---"}\n"
    end

    #show info about student
    def print_info()
        puts "<----------------->"
        puts (self)
        puts "<----------------->\n\n"
    end

    #phone validation with regular expressions
    def self.is_phone_valid?(phone_number)
        phone_pattern = Regexp.compile(/^(?:\+7|8)[\s-]?(?:\(?\d{3}\)?[\s-]?)\d{3}[\s-]?\d{2}[\s-]?\d{2}$/)
        return phone_number.nil? || phone_pattern.match?(phone_number)
    end

    #fullname validation with regular expressions
    def self.is_fullname_valid?(fullname_string)
        fullname_string =~ /^[А-ЯЁA-Z][а-яёa-z]{1,}(-[А-ЯЁA-Z][а-яёa-z]{1,})?\s[А-ЯЁA-Z].\s?[А-ЯЁA-Z].$/
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
end