#Возвращает количество делителей числа, не делящихся на 3
def nmbr_not_dvsbl_by_3(num)  
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

#Возвращает минимальную нечётную цифру числа
def min_odd_digit_of_num(num) 
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

#Проверка двух чисел на взаимную простоту
def are_mutually_simple?(num_a, num_b)
    examined_value = num_a
    max_value = num_b
    if (num_b > num_a) then
        examined_value = num_b
        max_value = num_a
    end
    2.upto(examined_value / 2) do |x|
        if max_value % x == 0  && examined_value % x == 0 then
            return false
        end
    end
    return true
end

#Сумма цифр числа
def sum_of_digits(num)
    sum = 0
    while num != 0
        sum += num % 10
        num /= 10
    end
    return sum
end

#Произведение цифр числа
def prod_of_digits(num)
    prod = 1
    while num != 0
        prod *= num % 10
        num /= 10
    end
    return prod
end

#Возвращает сумму всех делителей числа, взаимно простых с суммой цифр числа
#и не взаимно простых с произведением цифр числа.
def sum_of_dividers_with_mutual_simplicity(num)
    dig_sum = sum_of_digits(num)
    dig_prod = prod_of_digits(num)
    # puts "digit sum: %d" % [dig_sum]
    # puts "digit product: %d" % [dig_prod]
    result_sum = 0
    2.upto(num / 2) do |x|
        mut_simple_flag = false        #флаг на взаимную простоту
        not_mut_simple_flag = false    #флаг на отстутствие взаимной простоты
        if num % x == 0 then           #если это делитель
            #puts "#{num} % #{x} == #{num % x == 0}"
            if are_mutually_simple?(x, dig_sum) == true || are_mutually_simple?(num, dig_sum) == true then
                mut_simple_flag = true
            end
            if are_mutually_simple?(x, dig_prod) == false || are_mutually_simple?(num, dig_prod) == true then
                not_mut_simple_flag = true
            end
            if mut_simple_flag == true && not_mut_simple_flag == true then
                #puts "result_sum += #{x}"
                result_sum += x
            end
        end 
    end
    return result_sum
end

puts "Sum of dividers: #{sum_of_dividers_with_mutual_simplicity(35)}" #non-zero example