require 'pg'

#Singleton
class DB_connection
    private_class_method :new
    private attr_accessor :connection

    #Static method for returning or creating one instance for all program
    def self.instance
        @instance ||= new
    end

    def initialize
        self.connection = self.connect
    end

    def connect(dbname = "Students", user = "flaim", password = "Light_47", host = "localhost", port = 5432)
        raise "Connection already established" if self.connection
        begin
            return PG.connect(
                dbname: dbname,
                user: user,
                password: password,
                host: host,
                port: port
            )
        rescue PG::Error => ex
            raise "Connection failed: #{ex.message}"
        end
    end

    def connected?
        return !connection.nil?
    end

    def execute_query(query)
        raise "Establish the connection first" if !connected?
        begin
            connection.exec(query)
        rescue PG::Error => ex
            raise "Query execution failed: #{ex.message}"
        end
    end

    def close_connection()
        raise "No connection to close" if !connected?
        begin
            self.connection.close
            self.connection = nil
        rescue PG::Error => ex
            raise "Failed to close connection: #{e.message}"
        end
    end

    #Single instance variable
    private
    @instance = nil
end