class Array
  def two_sum
    array = []

    self.each_index do |idx1|
      (idx1 + 1...self.length).each do |idx2|
        if self[idx1] + self[idx2] == 0
           array << [idx1, idx2]
         end
      end
    end

    array
  end
end

p [-1, 0, 2, -2, 1].two_sum
