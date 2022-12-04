# frozen_string_literal: true

@file_data = File.read('02_input.txt').split(/\n/)

def strategy_guide(array)
  return if array.nil?

  total_score = 0
  array.each do |round|
    duel = round.split(' ')
    total_score += 1 if duel[1] == 'X'
    total_score += 2 if duel[1] == 'Y'
    total_score += 3 if duel[1] == 'Z'

    # winning
    if  (duel[1] == 'X' && duel[0] == 'C') ||
        (duel[1] == 'Y' && duel[0] == 'A') ||
        (duel[1] == 'Z' && duel[0] == 'B')
      total_score += 6
    # drawing
    elsif (duel[1] == 'X' && duel[0] == 'A') ||
          (duel[1] == 'Y' && duel[0] == 'B') ||
          (duel[1] == 'Z' && duel[0] == 'C')
      total_score += 3
    end
  end

  total_score
end

puts 'initial strategy score'
puts strategy_guide(@file_data)
