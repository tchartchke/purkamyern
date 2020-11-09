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
    if !self.pokemon.find { |entry| entry.name == name }
      new_pokemon = Api.new.get_pokemon_by_name(name)
      self.pokemon.add?(new_pokemon)
      self.scanned_in += 1
    else
      puts "#{name} is already in your pokedex"
    end
  end

  def self.all
    @@all
  end
end
