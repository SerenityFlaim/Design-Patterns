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

    private
    attr_accessor :array
end