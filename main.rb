require "tty-prompt"
require_relative "player"

prompt = TTY::Prompt.new

name = prompt.ask("What is your name")
player_class = prompt.select("Choose your class", ["Warrior", "Priest", "Thief"])

player = Player.new(name, player_class)

while player.life_points >= 0 do
    action = prompt.select("action", ["Attack", "Defend", "Use potion"])

    player.send(action.downcase.sub(" ", "_").to_sym)

    puts player.info
end

puts "You died"