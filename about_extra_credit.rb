# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.
require './about_dice_project.rb'
require './about_scoring_project.rb'
require './player.rb'
require './game.rb'

new_game = Game.new
new_game.start_game