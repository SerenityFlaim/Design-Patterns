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

    def to_s
        return self.array.to_s
    end

    def at(ix)
        return self.array.at(ix)
    end

    private
    attr_accessor :array
end