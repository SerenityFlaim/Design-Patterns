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