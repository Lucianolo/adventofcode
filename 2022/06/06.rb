def find_marker(input, distinct_seq_length)
  buffer = []
  prev_four = []
  input.chars.each do |char|
    buffer.push(char)
    prev_four.shift if prev_four.length > distinct_seq_length - 1
    prev_four.push(char)

    break if prev_four == prev_four.uniq && prev_four.length == distinct_seq_length
  end
  buffer.length
end

input = File.read(File.join(__dir__, 'input.txt'))
puts find_marker(input, 4)
puts find_marker(input, 14)
