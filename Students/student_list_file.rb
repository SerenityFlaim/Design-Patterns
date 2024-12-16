require './student.rb'
require './student_short.rb'
require './data_list_student_short.rb'
require './binary_student_tree.rb'
class Student_list_file
    private attr_accessor :student_list, :data_storage_strategy

    def initialize(file_path, data_storage_strategy)
        self.data_storage_strategy = data_storage_strategy
        self.student_list = data_storage_strategy.read(file_path)
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

    #return DataList_student_short object containing n objects of k page
    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n
        students_short = self.student_list.map {|student| Student_short.new_from_student(student)}
        data_list ||= DataList_student_short.new(students_short)
        return data_list.set_list((data_list.get_selected(start, start + n)))
    end

    #sorts by initials
    def sort_by_fullname!
        self.student_list.sort_by! {|student| student.get_initials}
    end

    #adds student object to student list
    def append_student(student)
        begin
            check_unique_fields(email: student.email, telegram: student.telegram, phone: student.phone, github: student.github)
        rescue => ex
            raise ex
        end

        new_id = self.student_list.empty? ? 1 : self.student_list.max_by(&:id).id + 1
        student.id = new_id
        self.student_list << student
    end

    #checks whether fields collide using binary tree structure
    def check_unique_fields(email: nil, telegram: nil, phone: nil, github: nil)
        if !email.nil? && !unique_email?(email)
            raise 'Current email already exists.'
        end

        if !telegram.nil? && !unique_telegram?(telegram)
            raise 'Current telegram already exists'
        end

        if !phone.nil? && !unique_phone?(phone)
            raise 'Current phone already exists'
        end

        if !github.nil? && !unique_github?(github)
            raise 'Current github already exists'
        end
    end

    def unique_email?(email)
        return unique?(:email, email)
    end

    def unique_telegram?(telegram)
        return unique?(:telegram, telegram)
    end

    def unique_github?(github)
        return unique?(:github, github)
    end

    def unique_phone?(phone)
        return unique?(:phone, phone)
    end

    #returns whether or not given key_value of key_type of student collides
    def unique?(key_type, key_val)
        tree = StudentTree.new
        self.student_list.each do |student|
            tree.append(student)
        end
        return tree.find{|student| student.send(key_type) == key_val}.nil?
    end

    def replace_by_id(id, new_student)
        ix = self.student_list.find_index{|student| student.id == id}
        raise IndexError 'Unknown student id' if ix.nil?
        begin
            check_unique_fields(email: new_student.email, telegram: new_student.telegram, phone: new_student.phone, github: new_student.github)
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