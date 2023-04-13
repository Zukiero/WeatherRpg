require "tty-prompt"
require_relative "player"
require_relative "decision_maker"

prompt = TTY::Prompt.new

name = prompt.ask("What is your name")
player_class = prompt.select("Choose your class", Player::CHARACTER_CLASS.keys)

player = Player.new(name, player_class)
opponent = Player.new("Opponent", Player::CHARACTER_CLASS.keys.sample)

count = 0

def puts_delay(string)
  string.chars.each do |char|
    print char
    sleep 0.05
  end
  puts "\n"
end

def diff_info(previous_info, current_info)
  result = []
  current_info.each do |key, value|
    result << "#{key}: #{value} (#{value - previous_info[key]})"
  end

  result.join(" | ")
end

def display_winning_banner(winner, count)
  puts "######### WINNER #########"
  puts "    #{winner.name} won in #{count} turns"
  puts "#########################"
end

def winner(player, opponent)
  if opponent.life_points <= 0
    player
  elsif player.life_points <= 0
    opponent
  else
    false
  end
end

def has_winner?(player, opponent)
  winner(player, opponent) != false
end

until has_winner?(player, opponent) do
  player_action = prompt.select("action", Player::CHARACTER_ACTION.keys)

  opponent_action = DecisionMaker.new(Player::CHARACTER_ACTION.values, player, opponent).take_action

  previous_player_info = player.info
  previous_opponent_info = opponent.info

  player.action(Player::CHARACTER_ACTION[player_action], opponent)
  opponent.action(opponent_action, player)

  system("clear")

  puts_delay "   You choose #{player_action}"
  puts_delay "    Opponent choose #{opponent_action}"

  puts "######### Your info #########"
  puts "    #{diff_info(previous_player_info, player.info)}"
  puts "#############################"
  puts "\n"
  puts "######### Opponent info #########"
  puts "    #{diff_info(previous_opponent_info, opponent.info)}"
  puts "#############################"

  puts_delay "End of turn #{count}"

  puts_delay ("..........")
  count += 1

  display_winning_banner(winner(player, opponent), count) if has_winner?(player, opponent)
end