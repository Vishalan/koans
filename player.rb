class Player
  attr_accessor :player
  def initialize(id)
    @player = {
        id: id,
        total_score: 0,
        curr_score: 0,
        unused_dice: 5,
    }
    @player
  end

  def roll_dice(player)
    roll = DiceSet.new()
    rolled_dices = roll.roll(player[:unused_dice])
    puts "Player #{player[:id] + 1} rolls : #{rolled_dices.join(", ")}"
    calculate_score(rolled_dices)
  end

  def calculate_score(dice)
    result,dice_used = score(dice)
    @player[:unused_dice] -= dice_used
    @player[:unused_dice] = 5 if @player[:unused_dice].zero?
    result
  end
end