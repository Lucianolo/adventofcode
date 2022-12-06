def calculate_score(input)
  rows = input.split("\n")
  score = 0
  shape_scores = [1, 2, 3]
  game_scores = [0, 3, 6]
  rows.each do |row|
    game = row.split(' ')
    opponent_idx = game[0].ord - 'A'.ord
    outcome = game_scores[game[1].ord - 'X'.ord]

    score += outcome
    score += case outcome
             when 0
               shape_scores[(opponent_idx - 1) % 3]
             when 3
               shape_scores[opponent_idx]
             else
               shape_scores[(opponent_idx + 1) % 3]
             end
  end
  score
end

input = File.read(File.join(__dir__, 'input.txt'))
puts calculate_score(input)
