def find_top_n_max_calories(input, n)
  list = input.split("\n\n")
  list.sort { |a, b| get_sum(b) <=> get_sum(a) }.first(n).reduce(0) { |tot, curr| tot + get_sum(curr) }
end

def get_sum(string_list)
  string_list.split("\n").reduce(0) { |sum, num| sum + num.to_i }
end

input = File.read(File.join(__dir__, 'input.txt'))

puts find_top_n_max_calories(input, 1)
puts find_top_n_max_calories(input, 3)
