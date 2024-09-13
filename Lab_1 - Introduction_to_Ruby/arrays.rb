def min_for(array)
    min = array[0]
    for el in array do
        if el < min then
            min = el
        end
    end
    return min
end


def min_while(array)
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

def find_value_for(array, value)
    i = 0
    for el in array do
        if el == value then
            return i
        end
        i += 1
    end
    return -1
end

def find_value_while(array, value)
    i = 0
    while i < array.size
        if array[i] == value
            return i
        end
        i += 1
    end
    return -1
end

def find_first_positive_for(array)
    i = 0
    for el in array do
        if el > 0 then
            return i
        end
        i += 1
    end
    return -1
end

def find_first_positive_while(array)
    i = 0
    while i < array.size
        if array[i] > 0 then
            return i
        end
        i += 1
    end
    return -1
end
