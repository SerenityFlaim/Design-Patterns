#find one unique element in array
def find_unique_element(arr)
    num_set = arr.to_set
    unique_arr = num_set.to_a
    if (arr.count(unique_arr[0]) == 1)
        result = unique_arr[0]
    else
        result = unique_arr[1]
    end
    return result
end

#find two smallest numbers in array
def find_two_min_elements(arr)
    arr.sort!()
    return arr[0], arr[1]
end

#find element in array closest to real R
def find_closest_real_element(arr, r)
    result = arr.min_by{|el| (r - el).abs}
    return result
end