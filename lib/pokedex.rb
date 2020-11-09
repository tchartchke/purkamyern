# frozen_string_literal: true

class Pokedex
  attr_accessor :scanned_in, :pokemon, :owner

  @@all = Set.new

  def initialize(owner)
    @owner = owner
    @scanned_in = 0
    @pokemon = Set.new
    @@all.add(self)
  end

  def scan_pokemon(name)
    if !found?(name)
      new_pokemon = Api.new.get_pokemon_by_name(name)
      pokemon.add?(new_pokemon)
      self.scanned_in += 1
    else
      puts "#{name} is already in your pokedex"
    end
  end

  def get_id(name)
    poke = found?(name)
    poke ? poke.id : nil
  end

  def found?(name)
    pokemon.find { |entry| entry.name == name}
  end

  def self.all
    @@all
  end
end
