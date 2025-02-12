require_relative "lib/game"

# ruby tic_tac_toe.rb

print "Ready to play? (Y/n)"
if STDIN.gets.strip == "n"
  puts "Come back later when you're ready"
  exit(1)
end

game = Game.new

game.start

game.prepare while game.turn != 0
