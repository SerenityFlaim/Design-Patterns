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