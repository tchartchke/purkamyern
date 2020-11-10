class Purkamyern::Cli

  def call
    puts "System booting...\nWelcome to your Pokedex."
    set_dex
    @top_input = ""
    until @top_input == 'exit'
      main_menu
      @top_input = gets.strip
      case @top_input
      when "1"
        scan_pokemon
      when "2"
        lookup_pokemon
      when "3"
        pokemon_of_type
      when "4"
        my_pokemon
      when "5"
        dex_stats
      when "exit"
        break
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
    puts "You now have access to #{@dex.owner}'s Pokedex."
  end

  def main_menu
    puts <<~DOC
    
MAIN MENU
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
    if new_pokemon
      puts @dex.seen > size ? "#{new_pokemon.name.capitalize} (#{new_pokemon.id}) was added to your Pokedex" : 'Pokemon already in Pokedex'
    else
      puts "Cannot find #{name}"
    end
  end

  def lookup_pokemon
    print 'Enter Pokemon ID or Name to look up: '
    val = gets.strip.downcase
    poke = @dex.seen?(val)
    if poke
      print_pokemon(poke)
    else
      puts "Could not find #{val} in Pokedex"
    end
  end

  def pokemon_of_type
    puts 'Enter which type you would like to search for: '
    val = gets.strip.downcase
    # TODO: error check for valid pokemon_type
    poke = @dex.find_pokemons_of_type(val)
    if poke.empty?
      puts "Unknown type \"#{val}\". No Pokemon to display"
    else
      poke.each { |p| print_pokemon(p) }
    end
  end

  def my_pokemon
    return puts 'Your Pokedex is empty!' if @dex.pokemon.empty?

    @dex.pokemon.each { |p| print_pokemon(p) }
  end

  def print_pokemon(poke)
    puts "#{'%03d' % poke.id.to_i}: #{poke.name.capitalize}, #{poke.types.join('-')}"
  end

  def dex_stats
    puts "Personal Stats: #{@dex.seen} species seen."
    puts "Global Stats: #{Purkamyern::Pokemon.discovered} species discovered."
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
    puts 'Goodbye.'
    sleep(0.5)
  end
end

