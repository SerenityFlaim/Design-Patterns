#Task 2 - User Survey
puts "Username: "

user_name = ARGV[0]

puts "Hello, %s" % [user_name]
puts "Just curious... What is your favourite PL?"

ARGV.clear
language = gets.chomp

case language
when "Ruby"
    puts "Подлиза"
when "C++"
    puts "That's powerful"
when "Python"
    puts "Bruh"
when "Pascal"
    puts "Вы - Амаль"
else
    puts "It will be Ruby soon!"
end

#Task 3 - User command prompt and execu
puts "Enter Ruby command -> "
ruby_command = gets.chomp

puts "Enter OS command -> "
os_command = gets.chomp

puts "Executing Ruby command..."
eval(ruby_command)

puts "Executing OS command..."
exec(os_command)