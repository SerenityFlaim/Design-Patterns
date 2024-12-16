require "./student_short.rb"
require "./student.rb"
require_relative "data_table/data_table.rb"
require_relative "data_list/data_list_student_short.rb"
require './student_list_db.rb'
require './student_list_file.rb'
require_relative "data_storage_strategy/JSON_storage_strategy.rb"
# student_1 = Student.new("Philipp", "Matuha", "Andreevich", 1, "88005553535", "@Serenity_flaim", "phil_th@mail.ru", "https://github.com/SerenityFlaim")
# student_2 = Student.new("Sergey", "Lotarev", "Urievich", 2, "55-11-6782-8390", "@lotarv", "lotarev.serge@yandex.ru", "https://github.com/lotarv")
# student_3 = Student.new("Nikita", "Smirnov", "Olegovich", 3, "036-738-1441", "@zaiiran", nil, "https://github.com/ZaiiiRan")
# student_4 = Student.new("Asiet", "Cheush", "Aslanbievna", 4, "10-3971-4623", "@asyanix", nil, "https://github.com/asyanix")

student_1 = Student.new({
    name: "Philipp", 
    surname: "Matuha", 
    patronymic: "Andreevich", 
    telegram: "@Serenity_flaim", 
    phone: "+7(918)-010-67-15", 
    email: "phil_th@mail.ru",
    github: "https://github.com/SerenityFlaim",
    birthdate: "09-06-2004"
})

student_2 = Student.new({
    name: "Sergey",
    surname: "Lotarev", 
    patronymic: "Urievich", 
    id: 2,
    telegram: "@lotarv",
    github: "https://github.com/lotarv",
    birthdate: "26-10-2004"
})

student_3 = Student.new({
    name: "Nikita",
    surname: "Smirnov",
    patronymic: "Olegovich",
    telegram: "@zaiiran",
    phone: "89993334545",
    birthdate: "03-06-2004"
})

student_4 = Student.new({
    name: "Asiet",
    surname: "Cheush",
    patronymic: "Aslanbievna",
    github: "https://github.com/asyanix",
    id: 4,
    birthdate: "22-02-2005"
})

sl_file = Student_list_file.new("storage/students.json", JSON_storage_strategy.new)
#puts(sl_json.student_list)
result = sl_file.get_k_n_student_short_list(2, 2)

student_5 = Student.new({
    name: "Vlad",
    surname: "Vavakin",
    patronymic: "Olegovich",
    telegram: "@Renbhed",
    phone: "+7(807)-909-56-04",
    email: "vlad_os@mail.ru",
    github: "https://github.com/VavakinV",
    birthdate: "03-06-2004"
})

student_6 = Student.new({
    name: "Vladfake",
    surname: "Vavakinfake",
    patronymic: "Olegovichfake",
    telegram: "@neRenbhed",
    phone: "+7(000)-909-56-04",
    email: "ne_vlad_os@mail.ru",
    github: "https://github.com/neVavakinV",
    birthdate: "03-06-2004"
})

sl_file.append_student(student_5)

sl_file.delete_by_id(3)
puts("Deleted:")
puts(sl_file)
sl_file.replace_by_id(2, student_6)
puts("Appended:")
puts(sl_file)
puts(sl_file.get_student_short_count)

sl_db = Student_list_DB.new
puts("By ID:", sl_db.get_student_by_id(2))
puts("Pagination testing")
puts(sl_db. get_k_n_student_short_list(2, 2))
puts("Count: ", sl_db.get_student_count)