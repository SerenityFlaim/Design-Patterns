require './student_short.rb'
require './data_table.rb'
require './data_list.rb'

class DataList_student_short < DataList
    def get_names()
        return ["№", "fullname", "github", "contact"]
    end

    def get_data()
        names = self.get_names
        table = [names]

        cur_log = []
        cur_number = 1
        self.array.each do |object|
            cur_log.append(cur_number)
            cur_log.append(object.fullname)
            cur_log.append(object.github)
            cur_log.append(object.get_contact)
            table.append(cur_log)
            cur_number += 1
            cur_log.clear
        end
        return DataTable.new(table)
    end
end