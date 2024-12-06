require './student_short.rb'
require './data_table.rb'
require './data_list.rb'

class DataList_student_short < DataList
    #implementation of get_names() method for DataList
    def get_names()
        return ["№", "fullname", "github", "contact"]
    end

    #implementation of preprocess_data(table) method for DataList
    private def preprocess_data(table)
        test_t = []
        cur_log = []
        cur_number = 1
        self.array.each do |object|
            cur_log.append(cur_number)
            cur_log.append(object.fullname)
            cur_log.append(object.github)
            cur_log.append(object.get_contact)
            test_t.append(cur_log)
            table.append(cur_log)
            cur_number += 1
            cur_log = []
        end
        return table
    end
end