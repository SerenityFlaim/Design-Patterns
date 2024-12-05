class DataTable
    private attr_accessor :data_table

    def initialize(table)
        self.data_table = table
    end

    def get_element(log_index, column_index)
        return data_table[log_index][column_index]
    end

    def get_logs_count
        return data_table.count
    end

    def get_columns_count
        return !data_table[0].nil? ? data_table[0] : 0
    end

    def to_s
        result = ""
        for log in data_table do
            result += "["
            for element in data_table[log] do
                result += element.to_s + ", "
            end
            result = result[0..-2] + "]"
        end
    end
end
