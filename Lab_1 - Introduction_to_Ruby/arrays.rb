def min_for(array)  #1
    min = array[0]
    for el in array do
        if el < min then
            min = el
        end
    end
    return min
end


def min_while(array)    #2
    min = array[0]
    i = 0
    while i < array.size
        if array[i] < min then
            min = array[i]
        end
        i += 1
    end
    return min
end

def find_value_for(array, value)    #3
    i = 0
    for el in array do
        if el == value then
            return i
        end
        i += 1
    end
    return -1
end

def find_value_while(array, value)  #4
    i = 0
    while i < array.size
        if array[i] == value
            return i
        end
        i += 1
    end
    return -1
end

def find_first_positive_for(array)  #5
    i = 0
    for el in array do
        if el > 0 then
            return i
        end
        i += 1
    end
    return -1
end

def find_first_positive_while(array)    #6
    i = 0
    while i < array.size
        if array[i] > 0 then
            return i
        end
        i += 1
    end
    return -1
end

def init_array_from_file(path)
    array = File.read(path).split
    for i in 0...array.size do
        array[i] = array[i].to_i
    end
    return array
end

method_num = ARGV[0].to_i
file_path = ARGV[1]
ARGV.clear
arr = init_array_from_file(file_path)

case method_num
when 1
    puts "min_for result: #{min_for(arr)}"
when 2
    puts "min_while result: #{min_while(arr)}"
when 3
    puts "Enter value you want to find: "
    arr_value = gets.chomp.to_i
    puts "find_value_for result: #{find_value_for(arr, arr_value)}"
when 4
    puts "Enter value you want to find: "
    arr_value = gets.chomp.to_i
    puts "find_value_for result: #{find_value_while(arr, arr_value)}"
when 5
    puts "find_first_positive_for result: #{find_first_positive_for(arr)}"
when 6
    puts "find_first_positve_while result: #{find_first_positive_while(arr)}"
else
    puts "Incorrect method number (must be from 1 to 6)."
end