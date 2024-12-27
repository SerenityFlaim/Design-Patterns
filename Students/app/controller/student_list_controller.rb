require_relative '../view/student_list_view.rb'
require_relative '../../models/student_list/student_list_file.rb'
require_relative '../../models/data_storage_strategy/JSON_storage_strategy.rb'
require_relative '../../models/data_list/data_list_student_short.rb'


class Student_list_controller
    private attr_accessor :view, :student_list, :data_list

    def initialize(view)
        self.view = view
        begin
            self.student_list = Student_list_file.new('../students.json', JSON_storage_strategy.new)
            self.data_list = DataList_student_short.new([])
            self.data_list.add_observer(self.view)
        rescue StandardError => ex
            self.view.show_error_message("Ошибка при взаимодействии с данными #{ex.message}")
        end
    end

    def refresh_data
        self.students_list.get_k_n_student_short_list(self.view.current_page, self.view.items_per_page - 1, self.data_list)
        self.data_list.count = self.student_list.get_student_short_count
        self.data_list.notify
    end

    def create
        puts "Создание записи"
    end

    def update(ix)
        return if ix.nil?
        puts "Изменение записи с индексом: #{number}"
    end

    def delete(indexes)
        return if ix.nil?
        puts "Удаление записей с индексами #{indexes}"
    end
end
