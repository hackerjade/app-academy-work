class Array
  def my_uniq
      numbers = []
      self.each do |value|
         numbers << value unless numbers.include?(value)
       end
       numbers
    end
end

p [1,2,2,2,4,8,5,5].my_uniq
