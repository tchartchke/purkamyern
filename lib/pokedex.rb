class Pokedex
  attr_accessor :scanned_in, :pokemon, :owner

  def initialize(owner)
    @owner = owner
    @scanned_in = 0
    @pokemon = Set.new
  end

  def scan_pokemon(pokemon)
    self.pokemon.add?(pokemon)
    self.scanned_in += 1
  end

end