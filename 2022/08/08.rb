def find_visible_trees(input)
  matrix = build_matrix(input)
  transposed = matrix.transpose
  visible = 0
  matrix.each_with_index do |row, y|
    row.each_with_index do |el, x|
      if border?(matrix.length, row.length, y, x)
        visible += 1
        next
      end
      directions = [row[0..x - 1], row[x + 1..-1], transposed[x][y + 1..-1], transposed[x][0..y - 1]]
      visible += 1 if directions.find { |array| visible?(el, array) }
    end
  end
  visible
end

def find_best_scenic_score(input)
  matrix = build_matrix(input)
  transposed = matrix.transpose
  scenic_score = 0
  matrix.each_with_index do |row, row_index|
    row.each_with_index do |el, col_index|
      next if border?(matrix.length, row.length, row_index, col_index)

      scenic_score = [scenic_score, calculate_scenic_score(el, row, transposed[col_index], row_index, col_index)].max
    end
  end
  scenic_score
end

def visible?(element, array)
  lower_than_current = array.filter { |el| el < element }
  lower_than_current.length == array.length
end

def scenic_distance(element, array)
  index = array.index { |el| el >= element }
  index.nil? ? array.length : index + 1
end

def calculate_scenic_score(element, row, column, row_index, col_index)
  scenic_distance(element, row[0..col_index - 1].reverse) *
    scenic_distance(element, row[col_index + 1..-1]) *
    scenic_distance(element, column[0..row_index - 1].reverse) *
    scenic_distance(element, column[row_index + 1..-1])
end

def border?(rows, cols, row_index, col_index)
  col_index.zero? || row_index.zero? || col_index == rows - 1 || row_index == cols - 1
end

def build_matrix(input)
  matrix = []
  rows = input.split("\n")
  rows.each do |row|
    matrix.push(row.split('').map(&:to_i))
  end
  matrix
end

input = File.read(File.join(__dir__, 'input.txt'))

puts find_visible_trees(input)
puts find_best_scenic_score(input)
