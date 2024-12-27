require 'pg'
require './data_list_student_short'
require './student_short'
require './student'
require_relative 'database_interaction/db_connection.rb'

class Student_list_DB
    private attr_accessor :connection

    def initialize
        self.connection = DB_connection.instance
    end

    def get_student_by_id(id)
        requested_student = connection.execute_query("SELECT * FROM student WHERE id = #{id}")
        return Student.new_from_hash(requested_student[0])
    end

    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n
        student_hash = connection.execute_query("SELECT * FROM student LIMIT #{n} OFFSET #{start}")
        students = student_hash.map {|student_log| Student.new_from_hash(student_log)} 
        students_short = students.map {|student| Student_short.new_from_student(student)}
        return data_list ||= DataList_student_short.new(students_short)
    end

    def append_student(student)
        query_result = connection.execute_query(
            "INSERT INTO student (surname, name, patronymic, birthdate, telegram, email, phone, github)
            VALUES ('#{student.surname}', '#{student.name}', '#{student.patronymic}', '#{student.birthdate}', '#{student.telegram}', '#{student.email}', '#{student.phone}', '#{student.github}') RETURNING id"
        )
        student.id = query_result[0]['id'].to_i
    end

    def replace_by_id(id, student)
        query_result = connection.execute_query(
            "UPDATE student SET surname = '#{student.surname}', name = '#{student.name}', patronymic = '#{student.patronymic}', birthdate = '#{student.birthdate}', 
            telegram = '#{student.telegram}', email = '#{student.email}', phone = '#{student.phone}', github = '#{student.github}' WHERE id = #{id}"
        )
        raise "Student with id: #{id} not found" if query_result.cmd_tuples == 0
    end

    def delete_by_id(id)
        query_result = connection.execute_query("DELETE FROM student WHERE id = #{id}",)
        raise "Student with id: #{id} not found" if query_result.cmd_tuples == 0
    end

    def get_student_count
        query_result = connection.execute_query("SELECT COUNT(*) FROM student")
        query_result[0]['count'].to_i
    end
end