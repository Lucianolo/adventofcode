def total_priority(input)
  lines = input.split("\n")
  priority = 0
  lines.each do |line|
    first_half, second_half = line.partition(/.{#{line.size / 2}}/)[1, 2]
    existing_chars = first_half.chars.tally
    duplicate = second_half.split('').find { |item| existing_chars.key? item }

    priority += if duplicate.ord > 90
                  duplicate.ord - 'a'.ord + 1
                else
                  duplicate.ord - 'A'.ord + 26 + 1
                end
  end
  priority
end

def badge_types_priority(input)
  lines = input.split("\n")
  priority = 0
  (0...lines.length).step(3).each do |index|
    first = lines[index]
    second = lines[index + 1]
    third = lines[index + 2]

    existing_chars = first.chars.tally
    common = existing_chars.filter { |k, _| second.include?(k) && third.include?(k) }.keys[0].to_s
    priority += if common.ord > 90
                  common.ord - 'a'.ord + 1
                else
                  common.ord - 'A'.ord + 26 + 1
                end
  end
  priority
end

input = File.read(File.join(__dir__, 'input.txt'))
puts total_priority(input)
puts badge_types_priority(input)
