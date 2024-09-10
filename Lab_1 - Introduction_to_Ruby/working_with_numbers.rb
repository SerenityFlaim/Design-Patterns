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


def method_3(num) #Возвращает сумму всех делителей числа, взаимно простых с суммой цифр числа
    dig_sum, dig_prod = 0, 1              # и не взаимно простых с произведением цифр числа.
    num_dup = num
    while num_dup != 0         #находим сумму и произведение цифр числа
        digit = num_dup % 10
        dig_sum += digit
        dig_prod *= digit
        num_dup /= 10
    end
    puts "digit sum: %d" % [dig_sum]
    puts "digit product: %d" % [dig_prod]
    result_sum = 0

    2.upto(num / 2) do |x|

        if num % x == 0             #если делитель числа

            mut_simple_flag = true        #флаг на взаимную простоту
            not_mut_simple_flag = false   #флаг на отстутствие взаимной простоты

            2.upto(x / 2) do |y|    #проверяем на взаимную простоту с суммой цифр числа
                if dig_sum % y == 0         #нашли делитель != 1? - уже не подходит
                    mut_simple_flag = false
                    break
                end
            end
            if dig_sum % x == 0         #если само число является делителем суммы - не подходит
                mut_simple_flag = false
            end

            if mut_simple_flag == true  #если взаимно простое с суммой цифр, проверяем дальше
                puts "passed sum check: %d" % [x]
                1.upto(x / 2) do |y|    #проверка отстутствия взаимной простоты с произведением цифр
                    if dig_prod % y == 0    #если делится, то уже подходит
                        not_mut_simple_flag = true
                        break
                    end
                end
                if dig_prod % x == 0    #если не нашло делителя до этого, но само число делится на произведение - подходит
                    not_mut_simple_flag = true
                end

                if not_mut_simple_flag == true  #прошло две проверки - добавляем в результирующую сумму
                    result_sum += x
                    puts "passed all checks: %d" % [x]
                end
            end
            
        end

    end
    return result_sum
end

#puts "Method_3 test: %d" % [method_3(13562)] #non-zero example