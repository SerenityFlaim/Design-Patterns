require "./Student.rb"

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
    github: "https://github.com/SerenityFlaim"
})

student_2 = Student.new({
    name: "Sergey",
    surname: "Lotarev", 
    patronymic: "Urievich", 
    id: 2,
    telegram: "@lotarv"
})

student_3 = Student.new({
    name: "Nikita",
    surname: "Smirnov",
    patronymic: "Olegovich",
    phone: "89993334545",
    telegram: "@zaiiran"
})

puts(student_1.validate?())
puts(student_2.validate?())
puts(student_3.validate?())
student_1.print_info()
student_2.print_info()
student_3.print_info()