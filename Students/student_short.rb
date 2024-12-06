require "./person.rb"
class Student_short < Person

    include Comparable
    attr_reader :fullname
    private attr_writer :contact
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
        student_hash = {
            fullname: fullname,
            github: github,
            contact: contact
        }
        return student_hash
    end

    #constructor from an id and a string from get_info Student method
    def self.new_from_id_string(id, student_string)
        student_hash = self.parse_student_string(student_string)
        self.new(
            id,
            student_hash[:fullname],
            student_hash[:github],
            student_hash[:contact]
        )
    end

    #fullname setter with validation
    def fullname=(fullname)
        if(!self.class.is_fullname_valid?(fullname)) then
            raise ArgumentError "Fullname isnt' stated correctly."
        end
        @fullname = fullname
    end

    def contacts_stated?()
        !self.contact.nil?
    end

    def get_contact()
        @contact
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

    def <=>(other)
        if self.fullname > other.fullname
            return 1
        elsif self.fullname == other.fullname
            return 0
        else
            return -1
        end
    end
end