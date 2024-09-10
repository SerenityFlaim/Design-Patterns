def nmbr_not_dvsbl_by_3(num)  #Возвращает количество делителей числа, не делящихся на 3
    counter = 0
    1.upto(num / 2) do |x|
        if num % x == 0 && x % 3 != 0 then 
            counter += 1 
        end
    end
    if num % 3 != 0 then
        counter += 1
    end
    return counter
end

def min_odd_digit_of_num(num) #Возвращает минимальную нечётную цифру числа
    min = num
    while num != 0
        digit = num % 10
        if digit % 2 != 0 && digit < min
            min = digit
        end
        num /= 10
    end
    return min
end