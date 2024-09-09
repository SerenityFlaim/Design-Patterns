def nmbr_not_dvsbl_by_3(num)  #Количество делителей числа, не делящихся на 3
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