def hanoi
  towers = [[], [], []]
  solution = []
  puts "How many disk are there?"
  towerlength = gets.chomp.to_i - 1
  (0..towerlength).each do |value|
    towers[0] << value
    solution << value
  end
  p towers
  until towers[2] == solution
    puts "Which tower would you like to move from?"
    user_from = gets.chomp.to_i - 1
    from_tower = towers[user_from][0]
    until !from_tower.nil?
      puts "That's not a valid move"
      user_from = gets.chomp.to_i - 1
      from_tower = towers[user_from][0]
    end
    puts "Which tower would you like to move to?"
    user_to = gets.chomp.to_i - 1
    to_tower = towers[user_to][0]
    p [user_to, user_from, to_tower, from_tower]
    if to_tower.nil? || from_tower < to_tower
      towers[user_to].unshift(towers[user_from].shift)
    else
      puts "That's not a valid move!"
    end
    p towers
  end
  puts "CONGRADULATIONS YOU WINNO"
end

hanoi
