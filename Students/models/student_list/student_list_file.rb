require_relative '../student'
require_relative '../student_short.rb'
require_relative '../data_list/data_list_student_short.rb'
require_relative '../binary_student_tree.rb'
class Student_list_file
    private attr_accessor :student_list, :data_storage_strategy, :file_path

    def initialize(file_path, data_storage_strategy)
        self.data_storage_strategy = data_storage_strategy
        self.student_list = data_storage_strategy.read(file_path)
        self.file_path = file_path
    end

    #return student objects list from file of choice
    def read(file_path)
        return self.data_storage_strategy.read(file_path)
    end

    #write student objects list to file of choice
    def write(file_path)
        self.data_storage_strategy.write(file_path, self.student_list)
    end

    def get_student_by_id(id)
        self.student_list.find {|student| student.id == id}
    end

    def set_list_from_file
        self.student_list = data_storage_strategy.read(self.file_path)
    end

    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n

        selected_students = student_list[start, n] || []
        students_short = selected_students.map {|student| Student_short.new_from_student(student)}
        data_list ||= DataList_student_short.new(students_short, start)
        data_list.offset = start
        data_list.set_list(students_short)
        return data_list
    end

    #sorts by initials
    def sort_by_fullname!
        self.student_list.sort_by! {|student| student.get_initials}
    end
    #adds student object to student list
    def append_student(student)
        begin
            unique?(student)
        rescue => ex
            raise ex
        end

        new_id = self.student_list.empty? ? 1 : self.student_list.max_by(&:id).id + 1
        student.id = new_id
        self.student_list << student
    end

    #checks whether attribute values collide using binary tree structure
    private def unique?(student)
        tree = StudentTree.new
        self.student_list.each do |student|
            tree.append(student)
        end
        return !tree.find{|stud_node| stud_node == student}
    end

    def replace_by_id(id, new_student)
        ix = self.student_list.find_index{|student| student.id == id}
        raise IndexError 'Unknown student id' if ix.nil?
        begin
            unique?(new_student)
        rescue => ex
            raise ex
        end
        new_student.id = id
        self.student_list[ix] = new_student
    end

    def delete_by_id(id)
        self.student_list.reject! {|student| student.id == id}
    end

    def get_student_short_count
        return self.student_list.size
    end

    def to_s
        result = ""
        student_list.each do |student|
            result += student.to_s
        end
        return result
    end

end