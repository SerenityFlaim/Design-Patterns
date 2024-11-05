require 'minitest/autorun'
require './array_processor.rb'

class TestProcessor < Minitest::Test
    attr_reader :processor

    def setup
        self.processor = ArrayProcessor.new([2, 34, -92, 102, 444, 29, 393, 20, 7, 19, -85, 4])
    end

    def test_find_negative
        assert_equal(-92, processor.find {|el| el < 0})
    end

    def test_find_divisor_condition
        assert_equal(-85, processor.find {|el| el % 5 == 0 and el % 10 != 0})
    end

    def test_min_by_2x
        assert_equal(-92, processor.min_by {|elem|  elem * 2})
    end

    def test_min_by_opposite
        assert_equal(444, processor.min_by {|el| -el})
    end

    def test_inject_sum
        assert_equal(300005, processor.inject(-80500) {|sum, n| sum + n * n})
    end

    def test_inject_diff
        assert_equal(67369, processor.inject(70000) {|sum, n| sum - 3 * n})
    end

    def test_one_negative
        assert_equal(false, processor.one? {|el| el < 0})
    end

    def test_one_condition
        assert_equal(true, processor.one? {|el| el % 10 == (el / 10) % 10})
    end

    def test_flat_map_type
        assert_silent(){
            arr = ArrayProcessor.new([1, 3, 2, [93, 21, [92, 93]], 29])
            fm_arr = arr.flat_map {|el| -el}
            fm_arr.each do |el|
                if el.class == Array 
                    raise TypeError
                elsif el > 0
                    raise RuntimeError
                end
            end
        }
    end

    def test_all_type
        assert_equal(true, processor.all? {|el| el.class == Integer})
    end

    def test_all_value
        assert_equal(false, processor.all? {|el| el < 400})
    end

    private 
    attr_writer :processor
end