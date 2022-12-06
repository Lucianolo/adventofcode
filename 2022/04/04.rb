def contained_count(input, is_contained)
  lines = input.split("\n").reject(&:empty?)
  lines.count do |line|
    parts = line.match(/(\d+)-(\d+),(\d+)-(\d+)/)

    is_contained.call([parts[1], parts[2]], [parts[3], parts[4]]) ||
      is_contained.call([parts[3], parts[4]], [parts[1], parts[2]])
  end
end

def fully_contained?(range_a, range_b)
  range_a[0].to_i <= range_b[0].to_i && range_a[1].to_i >= range_b[1].to_i
end

def partially_contained?(range_a, range_b)
  (range_a[0].to_i..range_a[1].to_i).include?(range_b[0].to_i) ||
    (range_a[0].to_i..range_a[1].to_i).include?(range_b[1].to_i)
end

input = File.read(File.join(__dir__, 'input.txt'))

puts contained_count(input, method(:fully_contained?))
puts contained_count(input, method(:partially_contained?))
