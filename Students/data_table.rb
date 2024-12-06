class DataTable
    private attr_accessor :data_table

    def initialize(table)
        self.data_table = table
    end

    def get_element(log_ix, column_ix)
        if !log_ix.is_a?(Integer) || log_ix >= self.get_logs_count || log_ix < 0
            raise ArgumentError "Invalid row index"
        elsif !column_ix.is_a?(Integer) || column_ix >= self.get_columns_count || column_ix < 0
            raise ArgumentError "Invalid column index"
        end
        return self.data_table[log_ix][column_ix]
    end

    def get_logs_count
        return data_table.count
    end

    def get_columns_count
        return !data_table[0].nil? ? data_table[0].count : 0
    end

    def to_s
        result = ""
        for log in data_table do
            result += "["
            for element in log do
                result += element.to_s + ", "
            end
            result = result[0..-3] + "]\n"
        end

        return result
    end
end