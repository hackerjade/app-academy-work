def num_to_s(num, base)
  i = 0
  numbers = []
  base_16 = {10 => 'A', 11 => 'B', 12 => 'C', 13 => 'D', 14 => 'E', 15 => 'F'}
  
  until base ** i > num
    digit = (num / (base ** i)) % base
    if digit > 9
      numbers << base_16[digit]
    else
      numbers << digit
    end
    i += 1
  end

  numbers.reverse.join("")
end

def caesar_cipher(str, int)
  code = ""
  str.each_char do |letter|
    code << (letter.ord + int).chr
  end
  code
end

p caesar_cipher('hello', 3)
