class Cli
  def enter_world
    start
    name = gets.strip
    puts "huh #{name}, is it? That's a name alright. Here. Have this."
    Pokedex.new(name)
  end
  def scan
    print "Enter Pokemon Name"
    name = gets.strip

  end
end


#give person a pokedex
#let enter or look at pokes
#sacns in poke if wana enter into
#look at pokes -> gives poke summary, name, type, habitat
#lets look up pokes based of habitat

def start
  <<-DOC
  Hey! You there! You look like an adventure seeking 10 year old! Want to go out and do some research for me?\n
  Doesn't matter, I'm not taking no for an answer! What's your name?
  DOC
end