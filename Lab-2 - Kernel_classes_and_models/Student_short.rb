require "./Person.rb"
class Student_short < Person

    attr_reader :fullname, :contact
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
    private_class_method def self.parse_student_string(student_string)
        split = student_string.split()
        fullname, github, contact = split[0] + " " + split[1], split[2], split[3] + " " + split[4]
        student_hash = {
            fullname: fullname,
            github: github,
            contact: contact
        }
        return student_hash
    end

    #validate fullname, github, contact given in hash form
    private_class_method def self.validate_student_vals(student_hash)
        fullname, github = student_hash[:fullname], student_hash[:github]
        contact_split = student_hash[:contact].split(":")
        contact_type, contact_data = contact_split[0], contact_split[1].strip

        if(!self.is_fullname_valid?(fullname)) then
            raise ArgumentError "Fullname isnt' stated correctly."
        end

        if (!self.is_github_valid?(github)) then
            raise ArgumentError "Github isn't stated correctly."
        end

        case contact_type
        when "telegram"
            if(self.is_telegram_valid?(contact_data)) then
                contact = contact_data
            else
                raise ArgumentError "Telegram isn't stated correctly."
            end
        when "email"
            if(self.is_email_valid?(contact_data)) then
                contact = contact_data
            else
                raise ArgumentError "Email isn't stated correctly."
            end
        when "phone"
            if (self.is_phone_valid?(contact_data)) then
                contact = contact_data
            else
                raise ArgumentError "Email isn't stated correctly."
            end
        end
        return fullname, github, contact
    end

    #constructor from an id and a string from get_info Student method
    def self.new_from_id_string(id, student_string)
        student_hash = self.parse_student_string(student_string)
        fullname, github, contact = self.validate_student_vals(student_hash)
        self.new(
            id,
            fullname,
            github,
            contact
        )
    end

    #fullname setter with validation
    def fullname=(fullname)
        if(!self.class.is_fullname_valid?(fullname)) then
            raise ArgumentError "Fullname isnt' stated correctly."
        end
        @fullname = fullname
    end

    #contact setter
    def contact=(contact)
        @contact = contact
    end

    #to_s method override
    def to_s()
        "<----------------->\n" +
        "Fullname:  #{fullname}\n" +
        "ID:        #{@id ? @id : "---"}\n" +
        "Github:    #{@github ? @github : "---"}\n" +
        "Contact:   #{@contact ? @contact : "---"}\n" +
        "<----------------->\n\n"
    end

    #fullname validation with regular expressions
    def self.is_fullname_valid?(fullname_string)
        fullname_string =~ /^[А-ЯЁA-Z][а-яёa-z]{1,}(-[А-ЯЁA-Z][а-яёa-z]{1,})?\s[А-ЯЁA-Z].\s?[А-ЯЁA-Z].$/
    end
end