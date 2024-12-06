require_relative '../data_table/data_table.rb'
class DataList
    private attr_accessor :array

    def initialize(arr)
        self.array = arr.sort()
    end

    def select(number)
        raise ArgumentError "Select argument must be an integer" if !number.is_a?(Integer)
        raise ArgumentError "There is no #{number} index in data_list object of #{self.array.length} elements" if number >= self.array.length

        return self.array[number]
    end

    def get_selected(a, b)
        begin
            return self.array[a...b]
        rescue Exception
            raise ArgumentError "Invalid index range"
        end
    end

    def get_names()
        raise NotImplementedError
    end
    
    def preprocess_data(table)
        raise NotImplementedError
    end

    #template method for returning a data table
    def get_data()
        names = self.get_names #step 1 that needs to be implemented
        table = [names]
        preprocess_data(table) #step 2 that needs to be implemented
        return DataTable.new(table)
    end

    def set_list(new_list)
        self.array.clear()
        self.array = new_list.sort()
    end

    def to_s()
        return self.array.to_s
    end
end