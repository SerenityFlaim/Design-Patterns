require 'json'
require './student.rb'
require './data_storage_strategy.rb'

class JSON_storage_strategy < Data_storage_strategy
    #read from JSON file
    def read(file_path)
        if (File.exist?(file_path))
            json_arr = JSON.parse(File.read(file_path), symbolize_names: true)
            json_arr.map do |object|
                Student.new(**object)
            end
        end
    end

    #write to JSON file
    def write(file_path, students)
        student_hash = {}
        student_hash = students.map {|student| student.to_h}
        File.write(file_path, JSON.pretty_generate(student_hash))
    end
end