class Person

    attr_reader :id, :github
    private attr_writer :id

    #github validation with regular expressions
    def self.is_github_valid?(github_url)
        github_url.nil? || github_url =~ %r{^https?://github\.com/[a-zA-Z0-9_\-]+$} #%r allows you to have '/' without escaping them
    end

    #github setter with validation
    private def github=(github)
        if(!self.class.is_github_valid?(github))
            raise ArgumentError "Github isn't stated correctly"
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

    def get_contact()

    end
end