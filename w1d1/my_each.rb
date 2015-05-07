#partially solved

def double(array)
  array.map { |value| value * 2}
end

# p double([2,4,6,8])

class Array
  def my_each
    # length = self.length
    idx = 0
    until idx == self.length
      yield(self[idx])
      idx += 1
    end

    self
  end
end

# return_value = [1, 2, 3].my_each do |num|
#   puts num
# end.my_each do |num|
#   puts num
# end


def median(array)
  # array.sort!
  array = array.sort
  if array.length % 2 == 0
    (array[array.length / 2 - 1] + array[array.length / 2]) / 2.0
  else
    array[(array.length / 2)]
  end
end

# p median([3,5,6,2])


def concatenate(strings)
  strings.inject(:+)
end

# p concatenate(["Yay ", "for ", "strings!"])
