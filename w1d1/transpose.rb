# Come back to this one. It's solved.
def my_transpose(array)
  transposed_array = []
  (0..array.length - 1).each do |row|
    new_row = []
    (0..array.length - 1).each do |value|
      new_row << array[value][row]
    end
    transposed_array << new_row
  end
  transposed_array
end

p my_transpose([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ])
