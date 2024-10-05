class Person

    attr_reader :id, :github
    private attr_writer :id

    #github setter with validation
    private def github=(github)
        if(!self.class.is_github_valid?(github))
            raise ArgumentError "Github isn't stated correctly"
        end
        @github = github
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

    #phone validation with regular expressions
    def self.is_phone_valid?(phone_number)
        phone_pattern = Regexp.compile(/^(?:\+7|8)[\s-]?(?:\(?\d{3}\)?[\s-]?)\d{3}[\s-]?\d{2}[\s-]?\d{2}$/)
        return phone_number.nil? || phone_pattern.match?(phone_number)
    end
end