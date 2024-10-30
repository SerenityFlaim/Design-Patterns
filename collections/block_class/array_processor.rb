class ArrayProcessor
    def initialize(arr)
        self.array = arr
    end

    def find
        self.array.each do |el|
            if (yield el) then
                return el
            end
        end
    end

    def min_by
        block_arr = []
        #we do this because min = arr[0] can be smaller than first valid block element
        self.array.each do |el|
            if (yield el) then
                block_arr << el
            end
        end
        min = block_arr[0]
        block_arr.each do |el|
            min = (yield el) && (el < min) ? el : min
        end
        return min
    end

    def inject(initial_operand = nil)
        accumulator = initial_operand.nil? ? self.array[0] : initial_operand
        start_index = initial_operand.nil? ? 1 : 0

        self.array[start_index..-1].each do |element|
          accumulator = yield(accumulator, element)
        end
      
        return accumulator
    end

    def one?
        counter = 0
        self.array.each do |el|
            if (yield el) then
                 counter += 1 
            end
            if counter > 1 then 
                return false
            end
        end
        return counter == 0 ? false : true
    end

    def to_s
        return self.array.to_set
    end

    def at(ix)
        return self.array.at(ix)
    end

    private
    attr_accessor :array
end