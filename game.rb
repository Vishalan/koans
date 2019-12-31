require File.expand_path(File.dirname(__FILE__) + '/neo')
# frozen_string_literal: true

class Game
  def initialize
    @all_players = []
    @end_game = {}
    @last_player = 0
    @round = 1
  end

  def process_score(score, player)
    player_index = player[:id].next
    puts "Score in this round: #{score}"
    puts "Total score: #{player[:total_score]}"
    puts '' if score.zero?
    if (player[:curr_score].zero? && score >= 0) || player[:curr_score] != 0
      if score != 0
        player[:curr_score] += score
        print "Do you want to roll the unused #{player[:unused_dice]} dice? (y/n) : "
        user_choice = gets.chomp
        player_index = evaluate_choice(user_choice, player, player_index)

      end
    end
    player_round_reset(player) if player_index == player[:id].next
    play(player_index)
  end

  def evaluate_choice(choice, player, player_index)
    if choice == 'y'
      player_index = player[:id] if player[:curr_score].positive?
    else
      puts "\n"
      if player[:curr_score] >= 300 || player[:total_score] >= 300
        player[:total_score] += player[:curr_score]
      end
      if player[:total_score] >= 3000 && !@end_game[:status]
        puts "----We're in the End Game----".upcase
        @end_game = { status: true, is_last_player: player_index == @all_players.size }
      end
    end
    player_index
  end
  def player_round_reset(player)
    player[:unused_dice] = 5
    player[:curr_score] = 0
  end

  def start_game
    print "\nEnter Number of players : "
    user_input = gets.chomp
    player_count = user_input.to_i
    idx = 0
    while player_count.positive?
      @all_players.push Player.new(idx)
      idx += 1
      player_count -= 1
    end
    puts "\nRound #1: \n\n"
    play(0)
  end

  def play(player_index)
    if @end_game[:is_last_player] && player_index == @all_players.size
      player_index = 0
      @last_player = 1
      @end_game[:is_last_player] = false if @end_game[:status]
    end
    if player_index < @all_players.size - @last_player
      player_obj =  @all_players[player_index]
      player_info = player_obj.player

      score = player_obj.roll_dice(player_info)

      process_score(score, player_info)
    else
      @round += 1
      puts "Round ##{@round}: \n ------" unless @end_game[:status]
      if !@end_game[:status] || @end_game[:is_last_player]
        play(0)
      else
        winner = @all_players.max_by do |player|
          player.player[:total_score]
        end
        puts "\nThe winner is : Player #{winner.player[:id] + 1} with score : #{winner.player[:total_score]}\n\n"
      end
    end
  end
end
