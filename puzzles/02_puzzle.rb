# frozen_string_literal: true

require '../elves_data'
include ElvesData

@file_data = ElvesData.read_file('../input/02_input.txt', /\n/)

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

def real_strategy_guide(array)
  return if array.nil?

  total_score = 0
  array.each do |round|
    duel = round.split(' ')

    case duel[1]
    when 'X' # lose
      total_score += 3 if duel[0] == 'A'
      total_score += 1 if duel[0] == 'B'
      total_score += 2 if duel[0] == 'C'
    when 'Y' # draw
      total_score += 3 + 1 if duel[0] == 'A'
      total_score += 3 + 2 if duel[0] == 'B'
      total_score += 3 + 3 if duel[0] == 'C'
    when 'Z' # win
      total_score += 6 + 2 if duel[0] == 'A'
      total_score += 6 + 3 if duel[0] == 'B'
      total_score += 6 + 1 if duel[0] == 'C'
    end
  end

  total_score
end

puts 'actual strategy score'
puts real_strategy_guide(@file_data)
