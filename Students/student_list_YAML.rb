require 'yaml'
require './student.rb'
require './student_short.rb'
require './data_list_student_short.rb'
require './binary_student_tree.rb'

class Student_list_YAML
    public attr_accessor :student_list

    def initialize(file_path)
        self.student_list = student_from_YAML(file_path)
    end

    def student_from_YAML(file_path)
        if (File.exist?(file_path))
            yaml_arr = YAML.safe_load(File.read(file_path), permitted_classes: [Date, Symbol])
            yaml_arr.map do |object|
                Student.new_from_hash(object)
            end
        end
    end

    def student_to_YAML(file_path, students)
        student_hash = students.map {|student| student.to_h}
        File.write(file_path, student_hash.to_yaml)
    end

    def get_student_by_id(id)
        self.student_list.find {|student| student.id == id}
    end

    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n
        students_short = self.student_list.map {|student| Student_short.new_from_student(student)}
        data_list ||= DataList_student_short.new(students_short)
        return data_list.set_list((data_list.get_selected(start, start + n)))
    end

    def sort_by_fullname!
        self.student_list.sort_by! {|student| student.get_initials}
    end

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
end