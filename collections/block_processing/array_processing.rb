#find one unique element in array
def find_unique_element(arr)
    unique_arr = arr.to_set.to_a
    return arr.count(unique_arr[0]) == 1 ? unique_arr[0] : unique_arr[1]
end

#find two smallest numbers in array
def find_two_min_elements(arr)
    arr.sort!()
    return arr[0], arr[1]
end

#find element in array closest to real R
def find_closest_real_element(arr, r)
    return arr.min_by{|el| (r - el).abs}
end

#find unique divisors in array of numbers
def find_unique_divisors(arr)
    return arr.flat_map {|num| (1..num).select { |divisor| num % divisor == 0}}.sort.to_set.to_a
end

#find common (>2 times) squared elemements < 100
def find_squares(arr)
    return arr.select{|element| arr.count(element) > 2 && element > 0 && element < 100 }.to_set.map{ |element| element * element}
end