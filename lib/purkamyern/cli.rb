require 'colorize'

class Purkamyern::Cli
  # TODO: Fix menu calling to get rid of extra "exit"
  def call
    puts "System booting...\nWelcome to your Pokedex."
    set_dex
    @top_input = "0"
    until @top_input == 'exit'
      main_menu if @top_index == "0"
      @top_input = gets.strip
      case @top_input
      when "1" then scan_pokemon
      when "2" then lookup_pokemon
      when "3" then pokemon_of_type
      when "4"then my_pokemon
      when "exit" then break
      else
        puts "Unrecognized selection. Please try again"
      end
    end
    goodbye
  end

  def set_dex
    print 'Please enter your name: '
    name = gets.strip
    @dex = Purkamyern::Pokedex.new(name)
    puts "You now have access to #{@dex.owner}'s Pokedex.".green
  end

  def main_menu
    puts "MAIN MENU".yellow.on_black.bold
    puts <<~DOC
    1. Scan in Pokemon to Pokedex
    2. Search Pokedex for Pokemon
    3. Look up Pokemon by type
    4. View Pokemon saved to Pokedex
    5. View Statistics
  Please Select an action. 'exit' to exit: 
  DOC
  end

  def scan_pokemon
    print 'Enter Pokemon to add to Pokedex: '
    name = gets.strip.downcase
    size = @dex.seen
    new_pokemon = @dex.scan(name)
    return puts "\tCannot find #{name}".red unless new_pokemon
    
    new_to_dex = @dex.seen > size
    scan_successful_msg(new_pokemon, new_to_dex)
  end

  def scan_successful_msg(poke, new_to_dex)
    if new_to_dex
      puts "\t#{poke.name.capitalize} #{poke.id} was added to your Pokedex".green
    else
      puts "\t#{poke.name.capitalize} already in Pokedex".red
    end
  end

  def lookup_pokemon
    print 'Enter Pokemon ID or Name to look up: '
    val = gets.strip.downcase
    poke = @dex.seen?(val)
    if poke
      print_pokemon(poke)
    else
      puts "\tCould not find #{val} in Pokedex".red
    end
  end

  def pokemon_of_type
    puts 'Enter which type you would like to search for: '
    val = gets.strip.downcase
    # TODO: error check for valid pokemon_type
    poke = @dex.find_pokemons_of_type(val)
    if poke.empty?
      puts "\tUnknown type \"#{val}\". No Pokemon to display".red
    else
      poke.each { |p| print_pokemon(p) }
    end
  end

  def my_pokemon
    return puts "\tYour Pokedex is empty!".red if @dex.pokemon.empty?

    @dex.pokemon.each { |p| print_pokemon(p) }
  end

  def print_pokemon(poke)
    puts "\t#{'%03d' % poke.id.to_i}".blue + "#{poke.name.capitalize}".green.bold + "#{poke.types.join('-')}".yellow
  end

  def dex_stats
    puts "\tPersonal Stats: " + "#{@dex.seen}".green.bold + " species seen."
    puts "\tGlobal Stats: " + "#{Purkamyern::Pokemon.discovered}".blue.bold + " species discovered."
  end

  def goodbye
    print '.'
    sleep(0.5)
    print '.'
    sleep(0.5)
    print '.'
    sleep(0.5)
    print '. Powering off. '
    sleep(1)
    puts 'Goodbye'.cyan
    sleep(0.5)
  end
end
