class Student

    #Student constructor
    def initialize(id, name, surname, patronymic, phone, telegram, email, github)
        @id = id
        @name = name
        @surname = surname
        @patronymic = patronymic
        @phone = phone
        @telegram = telegram
        @email = email
        @github = github
    end
    
    #id getter
    def id
        @id
    end

    #id setter
    def id=(value)
        @id = value
    end

    #name getter
    def name
        @name
    end

    #name setter
    def name=(value)
        @name = value
    end

    #surname getter
    def surname
        @surname
    end

    #surname setter
    def surname=(value)
        @surname = value
    end

    #patronymic getter
    def patronymic
        @patronymic
    end

    #patronymic setter
    def patronymic=(value)
        @patronymic = value
    end

    #phone getter
    def phone
        @phone
    end

    #phone setter
    def phone=(value)
        @phone = value
    end

    #telegram getter
    def telegram
        @telegram
    end

    #telegram setter
    def telegram=(value)
        @telegram = value
    end

    #github getter
    def github
        @github
    end

    #github setter
    def github=(value)
        @github = value
    end
end

