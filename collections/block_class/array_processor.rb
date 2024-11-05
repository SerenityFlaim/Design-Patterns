class ArrayProcessor
    def initialize(arr)
        self.array = arr
    end

    #returns the first element for which the block returns a truthy value
    def find
        self.array.each do |el|
            if (yield el) then
                return el
            end
        end
    end

    #returns the elements for which the block returns the minimum value
    def min_by
        result = self.array[0]
        self.array.each do |el|
            result = el if yield(el) < yield(result)
        end
        return result
    end
    
    #passes each operand to a block an returns accumulative operation
    def inject(initial_operand = nil)
        accumulator = initial_operand.nil? ? self.array[0] : initial_operand
        start_index = initial_operand.nil? ? 1 : 0

        self.array[start_index..-1].each do |element|
          accumulator = yield(accumulator, element)
        end
      
        return accumulator
    end

    #returns true if exactly one element of self meets a given criterion
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

    #recreation of flatten method, which is used in flat_map method recreation
    def recursive_flatten(arr, result = [])
        arr.each do |el|
            if el.class == Array
                recursive_flatten(el, result)
            else
                result << el
            end
        end
        return result
    end

    #returns an array of flattened objects returned by the block
    def flat_map
        flat_arr = recursive_flatten(self.array)
        for i in 0...flat_arr.count do
            flat_arr[i] = yield flat_arr[i]
        end
        return flat_arr
    end

    #returns whether every element meets a given criterion
    def all?
        self.array.each do |el|
            if !(yield el) then
                return false
            end
        end
        return true
    end

    def to_s
        return self.array.to_s
    end

    def at(ix)
        return self.array.at(ix)
    end

    private
    attr_accessor :array
    :recursive_flatten
end