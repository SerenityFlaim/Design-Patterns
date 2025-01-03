require_relative '../data_table/data_table.rb'
class DataList
    private attr_accessor :array, :observers, :selected
    private attr_reader :offset
    attr_writer :offset
    attr_accessor :count

    def initialize(arr, offset = 0)
        self.array = arr
        self.observers = []
        self.selected = []
        self.offset = offset
        self.count = 0
    end

    def select(number)
        self.selected << number unless self.selected.include?(number)
    end

    def get_selected
        return self.selected
    end

    def get_names()
        raise NotImplementedError
    end
    
    def preprocess_data(table, offset)
        raise NotImplementedError
    end

    #template method for returning a data table
    def get_data()
        names = self.get_names #step 1 that needs to be implemented
        table = [names]
        preprocess_data(table, offset) #step 2 that needs to be implemented
        return DataTable.new(table)
    end

    def set_list(new_list)
        self.array.clear()
        self.array = new_list
    end

    def add_observer(observer)
        self.observers << observer
    end

    def notify
        return if observers.nil?
        observers.each do |observer|
            observer.set_table_params(self.get_names, self.count)
            observer.set_table_data(self.get_data)
        end
    end

    def to_s()
        return self.array.to_s
    end
end