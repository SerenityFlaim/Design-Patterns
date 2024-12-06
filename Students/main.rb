require "./student.rb"
require "./student_short.rb"
require "./binary_student_tree.rb"
require "./data_list_student_short.rb"
require "./data_table.rb"
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

sh_1 = Student_short.new_from_student(student_1)
sh_2 = Student_short.new_from_student(student_2)
sh_3 = Student_short.new_from_student(student_3)
sh_4 = Student_short.new_from_student(student_4)

st_sh_list = DataList_student_short.new([sh_1, sh_2, sh_3, sh_4])
st_sh_table = st_sh_list.get_data
puts(st_sh_table, "\n")
st_sh_list.set_list([sh_2, sh_3, sh_4])
st_sh_table = st_sh_list.get_data
puts(st_sh_table)