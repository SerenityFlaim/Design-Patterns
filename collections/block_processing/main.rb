require './array_processing.rb'

#reads an array from keyboard
def keyboard_input
    puts "Enter array (all numbers must be seperated by a space):"
    return arr = gets.chomp.split.map{|el| el.to_f}
end

#reads an array from file
def file_input
    puts "State file path:"
    file_path = gets.chomp

    begin
        arr = File.read(file_path).split.map{|el| el.to_f}
    rescue Errno::ENOENT
        if file_path.nil? || file_path.empty? then
            puts "Empty file path."
        elsif !File.exist?(file_path) then
            puts "File does not exist."
        end
        raise ArgumentException
    end
    return arr
end

#processing user array input choice and returning an array
def array_input
    arr = []
    loop do
        puts "\nChoose array input method:"
        puts "1 -> Via keyboard"
        puts "2 -> Via file"

        method = gets.chomp.to_i

        case method
        when 1
            arr = keyboard_input
            break
        when 2
            arr = file_input
            break
        else
            puts "no such command."
        end
    end
    puts "\n\n"
    puts "Array: #{arr}"
    return arr
end

#command 1
def display_unique_element
    arr = array_input
    puts "<1>Unique element: #{find_unique_element(arr)}"
end

#command 2
def dispay_two_min_elements
    arr = array_input
    puts "<2>Two smallest numbers: #{find_two_min_elements(arr)}"
end

#command 3
def display_closest_real_element
    arr = array_input
    puts "\nEnter real number:"
    r = gets.chomp.to_f
    puts "<3>Closest array element to #{r}: #{find_closest_real_element(arr, r)}"
end

#command 4
def display_unique_divisors
    arr = array_input
    puts "<4>Unique divisors of a number group: #{find_unique_divisors(arr)}"
end

#command 5
def dispay_squares
    arr = array_input
    puts "<5>Required squares: #{find_squares(arr)}"
end

def menu
    loop do
        puts "Choose a command:"
        puts "1 -> Find one unique element"
        puts "2 -> Find two smallest numbers"
        puts "3 -> Find element of an array, closest to given real element given"
        puts "4 -> Find unique divisors of a number group"
        puts "5 -> Get squares of numbers, which are repeated more than 2 times and fall into section [0, 100]"
        puts "0 -> exit"

        command = gets.chomp.to_i
        puts "\n"

        case command
        when 1
            display_unique_element
        when 2
            dispay_two_min_elements
        when 3
            display_closest_real_element
        when 4
            display_unique_divisors
        when 5
            dispay_squares
        when 0
            exit
        else
            puts "No such command."
        end

        puts "\n\n"
    end
end

menu