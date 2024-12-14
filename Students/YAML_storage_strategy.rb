require 'yaml'
require './student.rb'
require './data_storage_strategy.rb'

class YAML_storage_strategy < Data_storage_strategy
    #read from YAML file
    def read(file_path)
        if (File.exist?(file_path))
            yaml_arr = YAML.safe_load(File.read(file_path), permitted_classes: [Date, Symbol])
            yaml_arr.map do |object|
                Student.new_from_hash(object)
            end
        end
    end

    #write to YAML file
    def write(file_path, students)
        student_hash = students.map {|student| student.to_h}
        File.write(file_path, student_hash.to_yaml)
    end
end