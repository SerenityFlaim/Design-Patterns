require_relative '../student_short.rb'
require_relative '../data_table/data_table.rb' 
require_relative './data_list.rb'

class DataList_student_short < DataList
    #implementation of get_names() method for DataList
    def get_names()
        return ["№", "fullname", "github", "contact"]
    end

    #implementation of preprocess_data(table) method for DataList
    private def preprocess_data(table, start_ix)
        cur_log = []
        cur_number = start_ix + 1
        self.array.each do |object|
            cur_log.append(cur_number)
            cur_log.append(object.fullname)
            cur_log.append(object.github)
            cur_log.append(object.get_contact)
            table.append(cur_log)
            cur_number += 1
            cur_log = []
        end
        return table
    end
end